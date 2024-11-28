# Use Ubuntu as the base image
FROM ubuntu:22.04

# Install Maven and BusyBox
RUN apt-get update && apt-get install -y \
    maven \
    busybox \
    && apt-get clean

# Set up Maven's default settings
RUN mkdir -p /root/.m2

# Set the default command to keep the container alive in Kubernetes
CMD ["tail", "-f", "/dev/null"]