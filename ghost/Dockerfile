ARG GHOST_BUILD_DOCKER_IMAGE=${GHOST_BUILD_DOCKER_IMAGE}
FROM ${GHOST_BUILD_DOCKER_IMAGE}

ARG GHOST_DISQUS_SHORTNAME
ENV GHOST_DISQUS_SHORTNAME=${GHOST_DISQUS_SHORTNAME}

ENV BUILD_DEPS="gettext" \
    RUNTIME_DEPS="libintl"

RUN set -x && \
    apk add --update ${RUNTIME_DEPS} && \
    apk add --virtual build_deps ${BUILD_DEPS} && \
    cp "/usr/bin/envsubst" "/usr/local/bin/envsubst" && \
    apk del build_deps

COPY files/disqus.template "${GHOST_INSTALL}/"
COPY files/docker-entrypoint.sh "/usr/local/bin"
RUN chmod a+x "/usr/local/bin/docker-entrypoint.sh" \
    && envsubst '${GHOST_DISQUS_SHORTNAME}' < "${GHOST_INSTALL}/disqus.template" > "${GHOST_INSTALL}/disqus.txt" \
    && rm -f "${GHOST_INSTALL}/disqus.template"

