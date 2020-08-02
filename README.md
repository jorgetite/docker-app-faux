# Docker WebFaux
Docker WebFaux is a docker image based on [nginx](https://hub.docker.com/_/nginx) that can be used to create containers exposing a static single page web site in port 80. The Dockerfile allows to create up to seven variants of the image; that is seven different versions of the web site. These variant images can be used to quickly spawn containers for learning, testing or demonstration purposes.


## How to use this image
To spin up a new container execute the following command:
```Shell
docker run -d --name blue-app  jorgetite/webfaux:1.0.blue
```

If you want to expose the container through an external port:
```Shell
 docker run -d --name green-app  -p 8080:80 jorgetite/webfaux:1.0.green
 ```
 Then you can hit http://localhost:8080 or http://{host-ip}:8080 in your browser.

Other Nginx advanced options can be found in the official [nginx](https://hub.docker.com/_/nginx) image page.

 ### Environment variables
The behavior of new containers can be controlled using the following environment variables:
* WEBFAUX_BASE_PATH
  * The base path of the webapp (use in the `<base>` tag)
  * Defaults to `/`


## Website Variants
* black (default)
* blue
* green
* red
* yellow
* purple
* magenta

## Image Build

### Arguments
There are three build arguments:

* `BUILD_DATE` - Used to label the image with the build date of the image (org.label-schema.build-date) (Required)
* `BUILD_VERSION` - Used to label the image with build version (org.label-schema.version)
* `VARIANT` - Used to create the app variant.


### Building a variant
The following command builds the blue image variant:
```Shell
docker build --tag myrepo/webfaux:blue --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') --build-arg VARIANT=blue .
```

The following command builds the green image variant and specifies a BUILD_VERSION:
```Shell
docker build --tag myrepo/webfaux:1.0.green --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') --build-arg BUILD_VERSION=1.0 --build-arg VARIANT=green .
```


### Multi-arch build
```Shell
docker buildx build --platform linux/amd64,linux/arm64,linux/ppc64le,linux/s390x,linux/386,linux/arm/v7,linux/arm/v6 --no-cache --rm --tag myrepo/webfaux:1.0.blue --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') --build-arg BUILD_VERSION=v0.1 --build-arg VARIANT=blue --push .
```

See https://www.docker.com/blog/multi-arch-images/ for how to build multi-arch images.

### Supported Platforms (Archs)
* linux/386
* linux/amd64
* linux/arm64
* linux/arm/v7
* linux/arm/v6
* linux/ppc64le
* linux/s390x