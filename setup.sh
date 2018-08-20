#!/bin/bash
# Install dependencies
cd /source
pipenv install --deploy

# Run project setup
source /source/setup.sh

# Add project to runit
mkdir /etc/service/project
cp /source/run.sh /etc/service/project/run
chmod +x /etc/service/project/run
