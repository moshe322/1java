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
RUN tar -xzvf  apache-maven-3.9.6-bin.tar.gz -C /opt/maven 
# Set the working directory
WORKDIR /app
# Copy your application files into the container
COPY . /app
RUN mvn clean install
# Your additional Dockerfile instructions go here
CMD ["mvn", "clean", "install"]
