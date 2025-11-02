FROM nginx:1.29-alpine3.22
ENV NGINX_RATE_LIMIT_BURST=10
ENV NGINX_RATE_LIMIT_PER_SECOND=10
ADD ./etc/nginx/nginx.conf /etc/nginx/nginx.conf
ADD ./etc/nginx/templates /etc/nginx/templates
COPY ./etc/nginx/docker-entrypoint.d/100-extended-config.sh /docker-entrypoint.d/100-extended-config.sh
RUN rm /etc/nginx/conf.d/default.conf && \
    chmod +x /docker-entrypoint.d/100-extended-config.sh
