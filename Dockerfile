FROM phusion/baseimage:0.11

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

# Expose the web interface
EXPOSE 5000

# Configuration
VOLUME /config

# Source code directory
VOLUME /source

# Add setup script
RUN mkdir -p /etc/my_init.d
ADD setup.sh /etc/my_init.d/setup.sh
RUN chmod +x /etc/my_init.d/setup.sh

# Add dummy run script
RUN mkdir -p /etc/service/project
ADD run.sh /etc/service/project/run
RUN chmod +x /etc/service/project/run
