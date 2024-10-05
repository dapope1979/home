FROM alpine:3

RUN apk add --no-cache --update \
    samba-common-tools \
    samba-client \
    samba-server

EXPOSE 139/tcp 445/tcp

CMD ["smbd", "--foreground", "--debug-stdout", "--no-process-group"]
