FROM busybox
MAINTAINER Ferdinand Hübner <ferdinand.huebner@gmail.com>

ADD *.sh /
RUN chmod +x /export-gce-pd-stats.sh && chmod +x /run.sh && chmod +x /loop.sh

CMD ["/run.sh"]