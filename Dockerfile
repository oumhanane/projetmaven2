FROM maven 
COPY target/calculatord-0.0.1-SNAPSHOT.jar app.jar
CMD ["java","-jar", "app.jar"]