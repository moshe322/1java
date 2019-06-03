# Pull base image 
From tomcat:8-jre8 

# Maintainer 
MAINTAINER "thiru" 
COPY ./webapp.war /usr/local/tomcat/webapps
