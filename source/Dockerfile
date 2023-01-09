FROM docker.io/library/alpine:edge

# Copy in our package
COPY . /opt/radvd

# Add the Alpine SDK
RUN apk --no-cache add alpine-sdk

# Add our buildbot user
RUN adduser builder -D
RUN addgroup builder abuild

# Update APK cache so the dependency resolution stage of abuild works
RUN apk update

# Create directories and manage permissions
RUN mkdir -p /var/cache/distfiles && \
    chown -R builder:abuild /var/cache/distfiles && \
    chown -R builder:abuild /opt/radvd

# Switch to our builder user and set up APK build env
USER builder
RUN abuild-keygen -a -n

# Workdir
WORKDIR /opt/radvd

# Download our sources and validate checksums
RUN abuild checksum

# Show current group membership
# Seems like Podman doesn't reflect the group change above
# properly here but Docker does?
RUN id -G -n

# Build
RUN abuild -r
