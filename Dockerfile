# ---- Build stage ----
FROM gradle:9.1.0-jdk25-alpine AS build
WORKDIR /app

# cache dependencies
COPY build.gradle settings.gradle ./
COPY gradle gradle
COPY gradlew ./
RUN ./gradlew dependencies || true

COPY src ./src

RUN chmod 777 ./gradlew

RUN ./gradlew clean bootJar --no-daemon

FROM eclipse-temurin:25-jre-alpine
WORKDIR /app

COPY --from=build /app/build/libs/*.jar app.jar

EXPOSE 80

ENTRYPOINT ["java","-jar","/app/app.jar"]