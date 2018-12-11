#!/bin/bash
# Install dependencies
cd /source
pip3 install -r requirements.txt

# Run project setup
source /source/setup.sh

# Add project to runit
mkdir /etc/service/project
cp /source/run.sh /etc/service/project/run
chmod +x /etc/service/project/run
