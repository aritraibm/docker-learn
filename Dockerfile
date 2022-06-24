FROM openjdk:8
EXPOSE 8090
ADD target/docker-sample-api.jar docker-sample-api.jar
ENTRYPOINT [ "java", "-jar", "/docker-sample-api.jar" ]