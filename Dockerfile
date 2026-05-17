FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
RUN mvn package -DskipTests -B -U -Ddocker.skip=true

FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=build /app/mall-admin/target/mall-admin-*.jar app.jar
EXPOSE 8080
ENV SPRING_PROFILES_ACTIVE=railway
CMD ["java", "-Xmx256m", "-Xms128m", "-XX:MaxMetaspaceSize=128m", "-XX:+UseSerialGC", "-XX:+HeapDumpOnOutOfMemoryError", "-jar", "app.jar"]
