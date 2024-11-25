#!/bin/bash

# Define variables
JENKINS_URL="http://localhost:8080/"
USER_NAME="admin"  
TOKEN="111d0965a46e28978eff5af093cc67e28c"

OUTMSG="-------------------------------------"
# Print the current directory and list files
echo "I'm here:"
pwd
ls -l

echo "I'm here now:"
cd ..
pwd
ls -l

# Check if Jenkins CLI jar exists
if [ ! -f "./tools/jenkins-cli.jar" ]; then
    echo "Error: jenkins-cli.jar not found in the current directory."
    exit 1
fi

# Check if Java is installed
if ! command -v java &> /dev/null; then
    echo "Error: Java is not installed. Please install Java to continue."
    exit 1
fi

echo "java version : " 
java -version

# Execute Jenkins CLI to get the list of plugins
echo "Fetching plugins list from Jenkins..."
java -jar ./tools/jenkins-cli.jar -s $JENKINS_URL -auth "$USER_NAME:$TOKEN" list-plugins > ./resources/raw_plugins.txt

# Check if the plugins.txt file was generated successfully
if [ $? -ne 0 ]; then
    echo "Error: Failed to fetch plugins list. Please check your Jenkins URL, username, and token."
    exit 1
else
    echo "Plugins list saved to ./resources/plugins.txt."
fi

# Check if Python script exists
if [ ! -f "./tools/conv_plugins.py" ]; then
    echo "Error: Python script ./tools/conv_plugins.py not found."
    exit 1
fi

# Check if Python is installed
if ! command -v python &> /dev/null; then
    echo "Error: Python3 is not installed. Please install Python3 to continue."
    exit 1
fi

# Run the Python script to process the plugins list
echo "Running Python script to process plugins list..."
py ./tools/conv_plugins.py

# Check if the Python script executed successfully
if [ $? -ne 0 ]; then
    echo "Error: Python script failed to run."
    exit 1
else
    echo "Plugins list processed successfully."
fi

if ! command -v docker &> /dev/null; then
    echo "Error: Python3 is not installed. Please install Python3 to continue."
    exit 1
fi

echo $OUTMSG
echo "Docker version :"
docker -v
echo $OUTMSG

echo 'Stage (Docker Build)'
echo $OUTMSG
pwd
docker build -f ./jenkins-dockerfile/jenkins-master.dockerfile -t custom-jenkins:lts .


