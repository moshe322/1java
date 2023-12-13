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
RUN wget -qO /tmp/apache-maven.tar.gz "https://apache.osuosl.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz" 
RUN tar -xzvf /tmp/apache-maven.tar.gz -C $MAVEN_HOME --strip-components=1 && rm /tmp/apache-maven.tar.gz
# Update PATH to include Maven binaries
ENV PATH=$MAVEN_HOME/bin:$PATH
# Set the working directory
WORKDIR /app
# Copy your application files into the container
COPY . /app
# Your additional Dockerfile instructions go here
CMD ["mvn", "clean", "install"]
