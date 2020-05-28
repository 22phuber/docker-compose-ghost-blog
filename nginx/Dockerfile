ARG NGINX_BUILD_DOCKER_IMAGE=${NGINX_BUILD_DOCKER_IMAGE}
FROM ${NGINX_BUILD_DOCKER_IMAGE}

ARG SERVER_NAME
ARG SERVER_ALTERNATIVE_NAME
ENV SERVER_NAME=${SERVER_NAME}
ENV SERVER_ALTERNATIVE_NAME=${SERVER_ALTERNATIVE_NAME}

COPY files "/etc/nginx/"
RUN rm -rf "/etc/nginx/conf.d/default.conf" \
    && envsubst '${SERVER_NAME}' < "/etc/nginx/docker-entrypoint.template" > "/usr/local/bin/docker-entrypoint.sh" \
    && rm "/etc/nginx/docker-entrypoint.template" \
    && chmod a+x "/usr/local/bin/docker-entrypoint.sh"

RUN envsubst '${SERVER_NAME} ${SERVER_ALTERNATIVE_NAME}' < "/etc/nginx/vhost.template" > "/etc/nginx/vhost.conf" \
    && envsubst '${SERVER_NAME}' < "/etc/nginx/conf.d/certbot.template" > "/etc/nginx/conf.d/certbot.conf" \
    && envsubst '${SERVER_NAME}' < "/etc/nginx/includes/ssl.template" > "/etc/nginx/includes/ssl.conf" \
    && rm -rf "/etc/nginx/includes/ssl.template" "/etc/nginx/vhost.template" "/etc/nginx/conf.d/certbot.template"

ENTRYPOINT [ "docker-entrypoint.sh" ]