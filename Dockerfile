FROM debian:buster-slim
RUN apt-get update && apt-get install -y ffmpeg imagemagick
COPY entrypoint.sh /root/entrypoint.sh
RUN chmod a+x /root/entrypoint.sh

ENTRYPOINT [ "/root/entrypoint.sh" ]