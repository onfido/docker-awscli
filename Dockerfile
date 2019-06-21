FROM alpine:latest

RUN apk add --no-cache python py-pip jq \
	&& pip install --upgrade pip \
	&& pip install awscli

ADD entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

