FROM maven:3.9-eclipse-temurin-21 AS build
WORKDIR /app
COPY pom.xml .
COPY eureka-server/pom.xml eureka-server/
COPY api-gateway/pom.xml api-gateway/
COPY user-service/pom.xml user-service/
COPY patient-service/pom.xml patient-service/
COPY record-service/pom.xml record-service/
COPY triage-service/pom.xml triage-service/
COPY notification-service/pom.xml notification-service/
COPY eureka-server/src eureka-server/src/
RUN mvn -pl eureka-server -am package -DskipTests

FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
COPY --from=build /app/eureka-server/target/eureka-server-*.jar app.jar
EXPOSE 8761
ENTRYPOINT ["java", "-jar", "app.jar"]
