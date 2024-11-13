FROM openjdk:17
ARG JAR_FILE=api-gateway-1.0-SNAPSHOT.jar
COPY target/${JAR_FILE} app/${JAR_FILE}
WORKDIR /app
ENTRYPOINT ["java","-jar","app/${JAR_FILE}"]