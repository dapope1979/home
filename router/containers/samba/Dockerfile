FROM debian:bookworm-slim

RUN apt update
RUN apt install -y samba samba-client

RUN mkdir -p /backups
RUN mkdir -p /media
RUN mkdir -p /share

RUN useradd --system shareuser
RUN chown -R shareuser /backups
RUN chown -R shareuser /media
RUN chown -R shareuser /share

EXPOSE 137/tcp 138/tcp 139/tcp 445/tcp

CMD ["smbd", "--foreground", "--debug-stdout", "--no-process-group"]
