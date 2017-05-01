# rpi-alpine-h2o

Raspberry Pi compatible Docker Image with H2O HTTP Server based on Linux Alpine.

## Build the Docker Image
```bash
docker build -t jdequeant/rpi-alpine-h2o .
```
## Run the Docker Image
```bash
docker run -d --name h2o -it -p 8080:8080 \
-v /absolute/path/to/rpi-alpine-h2o/etc/h2o:/etc/h2o \
-v /absolute/path/to/rpi-alpine-h2o/www:/www \
-v /absolute/path/to/rpi-alpine-h2o/var/log/h2o:/var/log/h2o \
rpi-alpine-h2o
```

## License

DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE  

DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE 
TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION 

0. You just DO WHAT THE FUCK YOU WANT TO.
