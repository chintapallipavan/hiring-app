FROM tomcat:8.0.20-jre8

# Define environment variables for Nexus repository and the artifact to download
ENV NEXUS_REPO_URL="http://52.23.170.228:8081/repository/task/"
ENV ARTIFACT_PATH="in/javahome/hiring/0.1/hiring-0.1.war"

# Provide Nexus repository credentials
ARG NEXUS_USERNAME
ARG NEXUS_PASSWORD
ENV NEXUS_USERNAME=$admin
ENV NEXUS_PASSWORD=$admin

# Print debugging information
RUN echo "Nexus username: $NEXUS_USERNAME"
RUN echo "Nexus password: $NEXUS_PASSWORD"

# Download the WAR file from Nexus and copy it to the Tomcat webapps directory
# Use curl with credentials to download the file
RUN set -eux; \
    curl -u $NEXUS_USERNAME:$NEXUS_PASSWORD -O $NEXUS_REPO_URL$ARTIFACT_PATH; \
    mv hiring-0.1.war /usr/local/tomcat/webapps/hiring.war

EXPOSE 8080
CMD ["catalina.sh", "run"]

