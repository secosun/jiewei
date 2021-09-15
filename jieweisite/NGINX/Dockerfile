FROM alpine:3.12.0
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories
COPY default.conf /etc/nginx/conf.d/
RUN apk add --no-cache nginx && \
    mkdir -p /run/nginx && \
    touch /run/nginx/nginx.pid
EXPOSE 80
EXPOSE 443
WORKDIR /usr/share/nginx/html/
CMD nginx \
   && tail -F /var/log/nginx/access.log
