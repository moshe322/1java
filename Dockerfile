# Use an OpenJDK base image
FROM openjdk:11
# Install dependencies
RUN apt-get update && \
    apt-get install -y wget && \
    rm -rf /var/lib/apt/lists/*
# Install Maven
ENV MAVEN_VERSION=3.8.4
ENV MAVEN_HOME=/opt/maven
RUN mkdir -p /opt/maven 
WORKDIR /opt/maven/
RUN wget -qO "https://apache.osuosl.org/maven/maven-3/3.8.4/binaries/apache-maven-3.8.4-bin.tar.gz" 
RUN tar -xzvf  apache-maven-3.8.4-bin.tar.gz -C /opt/maven --strip-components=1 && rm /tmp/apache-maven.tar.gz
# Set the working directory
WORKDIR /app
# Copy your application files into the container
COPY . /app
# Your additional Dockerfile instructions go here
CMD ["mvn", "clean", "install"]
