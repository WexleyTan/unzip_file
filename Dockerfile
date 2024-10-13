# BUILD STAGE

FROM maven:3.8.7-eclipse-temurin-19 AS build

WORKDIR /app

COPY . .

RUN mvn clean package

# RUN STAGE

FROM eclipse-temurin:22.0.1_8-jre-ubi9-minimal

COPY --from=build /app/target/*.jar /app/app.jar

EXPOSE 9090

CMD ["java", "-jar", "/app/app.jar"]
