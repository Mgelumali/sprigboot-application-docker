FROM schoolofdevops/maven:spring AS build
WORKDIR /app
COPY . .
RUN mvn spring-javaformat:apply && \
    mvn package -DskipTests

FROM build AS test
CMD mvn clean test

FROM eclipse-temurin:8-jre AS run
WORKDIR /run
COPY --from=build /app/target/spring-petclinic-2.3.1.BUILD-SNAPSHOT.jar petclinic.jar
EXPOSE 8080
CMD java -jar petclinic.jar
