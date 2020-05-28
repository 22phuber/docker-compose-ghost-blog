ARG CERTBOT_BUILD_DOCKER_IMAGE=${CERTBOT_BUILD_DOCKER_IMAGE}
FROM ${CERTBOT_BUILD_DOCKER_IMAGE}

ARG DOMAIN
ARG ALTERNATIVE_DOMAIN
ARG CERTBOT_EMAIL
ENV DOMAIN=${DOMAIN}
ENV ALTERNATIVE_DOMAIN=${ALTERNATIVE_DOMAIN}
ENV EMAIL=${CERTBOT_EMAIL}

ENV BUILD_DEPS="gettext" \
    RUNTIME_DEPS="libintl"

RUN set -x && \
    apk add --update ${RUNTIME_DEPS} && \
    apk add --virtual build_deps ${BUILD_DEPS} && \
    cp "/usr/bin/envsubst" "/usr/local/bin/envsubst" && \
    apk del build_deps

COPY "files/docker-entrypoint.template" "/usr/local/bin/"

RUN envsubst '${DOMAIN} ${ALTERNATIVE_DOMAIN} ${EMAIL}' < "/usr/local/bin/docker-entrypoint.template" > "/usr/local/bin/docker-entrypoint.sh" \
    && chmod a+x "/usr/local/bin/docker-entrypoint.sh" \
    && mkdir -p "/var/log/letsencrypt/" \
    && rm -rf "/usr/local/bin/docker-entrypoint.template"


ENTRYPOINT [ "docker-entrypoint.sh" ]