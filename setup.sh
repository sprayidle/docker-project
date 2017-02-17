#!/bin/bash
# Install dependencies
cp /source/setup.py /tmp/setup.py
python /tmp/setup.py install

# Add project to runit
mkdir /etc/service/project
cp /source/run.sh /etc/service/project/run
chmod +x /etc/service/project/run
