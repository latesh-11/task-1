FROM maven as build
WORKDIR /app
COPY . .
RUN mvn clean install

# -------- Second Stage --------- #

FROM openjdk:11.0
WORKDIR /app
COPY . /app/
CMD [ "java","-jar","Uber.jar" ]