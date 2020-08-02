# base image
FROM nginx:alpine

# build arguments.
ARG BUILD_DATE
ARG BUILD_VERSION=v0.1
ARG VARIANT="black"

# Labels.
LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.build-date=${BUILD_DATE} \
      org.label-schema.name="test-nginx" \
      org.label-schema.description="Simple docker image based on nginx to mimic a simple application" \
      org.label-schema.url="https://github.com/jorgetite/docker-app-faux" \
      org.label-schema.vendor="jorgetite.com" \
      org.label-schema.version=${BUILD_VERSION} \
      org.label-schema.docker.cmd="docker run -d --name blue-app -p 8080:80 jorgetite/app-faux:v0.1.blue"

# Copy static files
COPY ./src/www /usr/share/nginx/html

# Sets the variant for the home page
RUN /bin/sed -i "s|{{variant}}|$VARIANT|" /usr/share/nginx/html/index.html

# Environment variables
ENV WEBFAUX_BASE_PATH="/"

# Copy custom entrypoint script
COPY ./src/docker/entrypoint.sh /webfaux-docker-entrypoint.sh
ENTRYPOINT ["/webfaux-docker-entrypoint.sh"]

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]