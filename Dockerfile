FROM alpine/git as clone
WORKDIR /app
RUN git clone https://github.com/TuVanNguyen/spring-petclinic.git 

FROM maven:3.5-jdk-8-alpine as build
WORKDIR /app
COPY --from=clone /app/spring-petclinic /app 
RUN mvn install 

FROM openjdk:8-jre-alpine
WORKDIR /app
COPY --from=build /app/target/*.jar . 
EXPOSE 8080
CMD ["java", "-jar", "spring-petclinic-2.2.0.BUILD-SNAPSHOT.jar"] 
