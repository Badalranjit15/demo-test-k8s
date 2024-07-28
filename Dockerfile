# Use your custom ACE image as the base image
FROM image-registry.openshift-image-registry.svc:5000/ace-int/my-custom-ace-image

# Set the environment variables for ACE
ENV LICENSE accept
ENV LANG en_US.UTF-8

# Copy the tar file from the repository into the image
COPY 12.0.12.4-ACE-LINUX64-DEVELOPER.tar.gz /tmp/12.0.12.4-ACE-LINUX64-DEVELOPER.tar.gz

# Install the necessary tools and ACE components
RUN tar -xzf /tmp/12.0.12.4-ACE-LINUX64-DEVELOPER.tar.gz -C /opt/ && \
    rm /tmp/12.0.12.4-ACE-LINUX64-DEVELOPER.tar.gz && \
    /opt/ibm-ace-12.0.12.4-iibinstall /opt/ibm/ace-12.0.12.4 && \
    rm -rf /opt/ibm-ace-12.0.12.4-iibinstall

# Source the ACE profile
RUN echo ". /opt/ibm/ace-12.0.12.4/server/bin/mqsiprofile" >> /etc/profile.d/ace.sh

# Set the work directory
WORKDIR /workspace

# Ensure the mqsipackagebar command is available in the PATH
ENV PATH=$PATH:/opt/ibm/ace-12.0.12.4/server/bin

# Set the entrypoint
ENTRYPOINT ["/bin/bash"]
