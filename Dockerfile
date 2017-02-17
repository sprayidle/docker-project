FROM phusion/baseimage:0.9.19

# Set correct environment variables
ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive

# Use baseimage-docker's init system
CMD ["/sbin/my_init"]

# Configure user nobody to match unRAID's settings
RUN \
usermod -u 99 nobody && \
usermod -g 100 nobody && \
usermod -d /home nobody && \
chown -R nobody:users /home 

# Disable SSH
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh

# Install Dependencies
RUN apt-get install -qy python wget 

RUN \
cd /tmp && \
wget -O get-pip.py https://bootstrap.pypa.io/get-pip.py && \
python get-pip.py

# Expose the web interface
EXPOSE 5000

# Configuration
VOLUME /config

# Source code directory
VOLUME /source

COPY /source/setup.py /tmp/setup.py
RUN python /tmp/setup.py install

# Add setup script
RUN mkdir -p /etc/my_init.d
COPY /source/setup.sh /etc/my_init.d/setup.sh
RUN chmod +x /etc/my_init.d/setup.sh

# Add project to runit
RUN mkdir /etc/service/project
COPY run.sh /etc/service/project/run
RUN chmod +x /etc/service/project/run
