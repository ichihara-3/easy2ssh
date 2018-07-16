#!/bin/bash

function exit_if_error () {
  if [ $? -gt 0 ]; then
    exit 1
  fi
}

function usage () {
  echo bash $0 INSTANCE_NAME
}

HOST_NAME=$1

if  [ $# -eq 0 ]; then
  usage
  exit 1
fi

ID=$(aws ec2 describe-instances \
    --filters "Name=tag:Name,Values=${HOST_NAME}"  \
    --query 'Reservations[0].Instances[0].InstanceId')

echo starting instances...
aws ec2 start-instances --instance-ids ${ID}
exit_if_error

echo rewrite ~/.ssh/config
DNS=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=myserver1" --query 'Reservations[*].Instances[*].PublicDnsName');
sed -i -e "N;s%\(Host ${HOST_NAME}.*HostName \).*$%\1${DNS}%" ~/.ssh/config
exit_if_error

echo done!
echo To ssh to ${HOST_NAME}, run \"ssh ${HOST_NAME}\"

ssh $HOST_NAME
exit_if_error

