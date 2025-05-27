#!/bin/sh


# Checking if the ENV variable is set
if [ -z "$ENV" ]; then
  echo "Error: ENV variable is not set."
  exit 1
fi

# Determine which YAML file to use based on the value of ENV
if [ "$ENV" = "dev" ]; then
  CONFIG_FILE="dev.yaml"
elif [ "$ENV" = "test" ]; then
  CONFIG_FILE="test.yaml"
elif [ "$ENV" = "trial" ]; then
  CONFIG_FILE="trial.yaml"
elif [ "$ENV" = "staging" ]; then
  CONFIG_FILE="staging.yaml"
else
  echo " Error: Unsupported ENV value '$ENV'. Supported values are 'dev', 'test', 'trial and 'staging' "
  exit 1
fi

apt-get update -y
apt-get install -y unzip curl wget
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip && ls -al && aws/install 
aws --version 
export AWS_ACCESS_KEY_ID=$aws_access_key_id 
export AWS_SECRET_ACCESS_KEY=$aws_secret_access_key
ls -al sourcecode
wget https://github.com/ekristen/aws-nuke/releases/download/v3.52.2/aws-nuke-v3.52.2-linux-amd64.tar.gz 
tar -xvf aws-nuke-v3.52.2-linux-amd64.tar.gz
chmod +x aws-nuke
mv aws-nuke /usr/local/bin/aws-nuke
aws-nuke nuke -c "sourcecode/nuke-config/$CONFIG_FILE" --force | grep "would remove" 
echo complete
