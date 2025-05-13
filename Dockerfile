FROM alpine:3.19

# Install curl and ca-certificates
RUN apk add --no-cache curl ca-certificates

# Set aws-nuke version
ENV AWS_NUKE_VERSION=3.51.1

# Download and install aws-nuke binary
RUN curl -L -o /usr/local/bin/aws-nuke https://github.com/rebuy-de/aws-nuke/releases/download/v${AWS_NUKE_VERSION}/aws-nuke-v${AWS_NUKE_VERSION}-linux-amd64 && \
    chmod +x /usr/local/bin/aws-nuke

WORKDIR /nuke

ENTRYPOINT ["aws-nuke"]
