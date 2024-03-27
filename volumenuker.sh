#!/bin/bash
# Volume Nuker - goes into an account and nukes all unused EBS volumes
# PLEASE USE WITH CAUTION
# Usage:
# 1) Make sure you have credentials in your ./aws/credentials for the RIGHT account
# 2) Execute this script
# 3) Get coffee because it might take a while depending on how many volumes you have
#
# author: JJJ

echo Executing Volume Nuker

## Functions ##

# Function: Log an event
# TODO: fix logging later...no time now we need to execute immediately!
#log() {
#    echo "[$(date +"%Y-%m-%d"+"%T")]: $*"
#}

# Function: Delete all the volumes from the list
nuke_volumes() {
  for volume_id in $volume_list; do
    echo "Nuking volume:$volume_id"
    aws ec2 delete-volume --volume-id $volume_id
    echo "Boom!! $volume_id nuked!"
  done
}

## Variables ##

# Get all volume IDs in region matching the filter criteria
volume_list=$(aws ec2 describe-volumes --region us-east-1 --filters Name=status,Values=available --query "Volumes[*].{ID:VolumeId}" --output text)

## Commands ##
nuke_volumes
