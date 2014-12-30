FROM hpess/chef:latest
MAINTAINER Paul Cooke <paul.cooke@hp.com>

RUN yum -y update && \
    yum -y install nginx && \
    yum clean all

RUN echo "daemon off;" >> /etc/nginx/nginx.conf && \
    echo "nginx on hpess" > /usr/share/nginx/html/index.html

EXPOSE 80

COPY services/* /etc/supervisord.d/
