FROM hpess/chef:latest
MAINTAINER Paul Cooke <paul.cooke@hp.com>

COPY nginx.repo /etc/yum.repos.d/nginx.repo

RUN yum -y update && \
    yum -y install nginx && \
    yum clean all

RUN mkdir -p /var/log/nginx && \
    mkdir -p /var/run/nginx && \
    chown -R nginx:nginx /var/log/nginx && \
    chown -R nginx:nginx /var/run/nginx && \
    chown -R nginx:nginx /usr/share/nginx/html && \
    setcap 'cap_net_bind_service=+ep' /usr/sbin/nginx

EXPOSE 80
EXPOSE 443

ENV chef_node_name nginx.docker.local
ENV chef_run_list nginx 

COPY services/* /etc/supervisord.d/
COPY cookbooks/ /chef/cookbooks/
ENV HPESS_ENV nginx
