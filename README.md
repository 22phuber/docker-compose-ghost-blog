# Docker compose starter kit with ghost blog, nginx, mariadb and certbot (SSL/TLS)

:warning: Project is still **WIP**. Some features may not work properly yet.

A [docker compose](https://docs.docker.com/compose/) starter kit for the [Ghost blogging platform](https://github.com/TryGhost/Ghost) features:
- SSL/TLS (HTTPS) using [certbot](https://certbot.eff.org/) with automated renewal
- [nginx](https://www.nginx.com/) as fast and reliable webserver
- [mariadb](https://mariadb.org/) as database.

Additional features:
- Support for [Disqus](https://disqus.com/) comments

## Requirements
You need a computer or server with
- Docker installed
- Internet access
- Ingress traffic on ports `80` and `443`

## Getting started

The current setup supports a `domain` name and an `alternative domain` name with `www.` prefix out of the box. But you can customize all settings.

1. Copy `.env.template` to `.env`
2. Change `.env` file and add **your values**. Also add, remove environment variables if needed.
3. Optional configurations:
   1. Edit the `docker-compose.yml` file: Change, add and remove environment variables if needed.
   2. Edit the `certbot/files/docker-entrypoint.sh` file to use `--staging` and/or `--debug` for the initial certbot certificate creation.
   3. If you migrate from another ghost blog: Export the content in the old admin panel. Copy existing blog data into `data/ghost/` and import content in the new admin panel.
5. Check the configuration: `docker-compose config`
6. Build the docker images: `docker-compose build --no-cache`
7. Run the docker compse setup in daemon mode in the backgroud: `docker-compose up -d`

Check logs: `docker-compose logs -f`
