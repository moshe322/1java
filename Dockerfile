
# Use an OpenJDK base image
FROM openjdk:11

# Set environment variables
ENV MAVEN_VERSION=3.8.4
ENV MAVEN_HOME=/opt/maven

# Install Maven
RUN mkdir -p $MAVEN_HOME && \
    wget -qO- "https://apache.osuosl.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz" | tar --strip-components=1 -xz -C $MAVEN_HOME

# Update PATH to include Maven binaries
ENV PATH=$MAVEN_HOME/bin:$PATH

# Set the working directory
WORKDIR /app

# Copy your application files into the container
COPY . /app

RUN mvn clean install

# Your additional Dockerfile instructions go here

CMD ["mvn", "clean", "install"]
