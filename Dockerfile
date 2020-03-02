FROM openjdk:8-jre-alpine
COPY target/*.war /app.war
CMD ["/usr/bin/java", "-jar", "app.war"]
