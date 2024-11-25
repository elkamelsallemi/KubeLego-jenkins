FROM jenkins/jenkins:lts

# Copy configurations
COPY ./resources/config.xml /var/jenkins_home/config.xml

# Install plugins
COPY ./resources/plugins.txt /usr/share/jenkins/plugins.txt
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/plugins.txt

