![Nginx](/nginx.jpeg?raw=true "Nginx")

This container builds on [hpess/chef](https://github.com/Hewlett-Packard-ESS/docker-chef) by adding nginx.

## Specifics
  - Nginx is build from source, and is using version 1.7.9 (Mainline).
  - Nginx configuration is stored in the volume /storage, if you mount an empty directory from your host to /storage, chef-zero is used to perform initial surface level configuration which will created the config files for you.  This will only be done if the files do not exist, therefore preserving and customisation you made add.
  - Just for ease, you can have chef-zero create a simple http:80 bound site for you, where the contents live in /storage/nginx/html.  Use the 'nginx_simple_http' flag below.
  - Nginx runs as the "docker" user in the "docker" group, which is created from the hpess/base image.  Subsequently you need to ensure that if you modify /storage/ outside of the container, you set the userid to 1250 and groupid to 1250, otherwise nginx in the container will not have permission to read those files.

## Use
The easiest way is probably with a fig file, like this:
```
nginx:
  hostname: 'nginx'
  image: hpess/nginx
  environment:
    nginx_simple_http: 'true'
  ports:
    - "8080:8080"
    - "8443:8443"   // SSL not currently implemented, coming soon...
  volumes:
    - ./storage:/storage
```

## License
This docker application is distributed under the MIT License (MIT).

Nginx itself is licenced under the [Two Clause BSD-like](http://nginx.org/LICENSE) license.

