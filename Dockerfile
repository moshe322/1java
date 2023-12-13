# Use an OpenJDK base image
FROM openjdk:11

# Install dependencies
RUN apt-get update && \
    apt-get install -y wget && \
    rm -rf /var/lib/apt/lists/*

# Install Maven
RUN mkdir -p /opt/maven 
WORKDIR /opt/maven/
RUN wget https://dlcdn.apache.org/maven/maven-3/3.9.6/binaries/apache-maven-3.9.6-bin.tar.gz 
RUN tar -xzvf apache-maven-3.9.6-bin.tar.gz -C /opt/maven 

# Add Maven to the PATH
ENV PATH=/opt/maven/apache-maven-3.9.6/bin:$PATH

# Set the working directory
WORKDIR /app

# Copy your application files into the container
COPY . /app

# Build your application with Maven
RUN mvn clean install

# Your additional Dockerfile instructions go here
CMD ["mvn", "clean", "install"]

FROM tomcat:8-alpine

WORKDIR /usr/local/tomcat/webapps

COPY --from=build /app/target/webapp.war /usr/local/tomcat/webapps

EXPOSE 8080

