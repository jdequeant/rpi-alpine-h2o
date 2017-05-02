FROM hypriot/rpi-alpine-scratch:edge
MAINTAINER jdequeant <jdequeant@gmail.com>

# H2O HTTP Server - Install server and deps
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories && \
echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
apk update && \
apk upgrade && \
apk add bash perl git bison alpine-sdk cmake openssl-dev automake libtool autoconf ninja && \
cd / && \
git clone https://github.com/libuv/libuv.git && \
cd libuv && \
sh autogen.sh && \
./configure && \
make -j $(($(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1)+1)) && \
make install && \
cd / && \
git clone https://github.com/tatsuhiro-t/wslay.git && \
cd wslay && \
cmake -G 'Ninja' . && \
ninja && \
ninja install && \
cd / && \
git clone https://github.com/h2o/h2o.git && \
cd h2o && \
git submodule update --init --recursive && \
cmake -DCMAKE_C_FLAGS_RELEASE= \
-DCMAKE_CXX_FLAGS_RELEASE= \
-DCMAKE_INSTALL_PREFIX=./dist \
-DCMAKE_BUILD_TYPE=Release \
-DCMAKE_VERBOSE_MAKEFILE=ON \
-Wno-dev && \
make && \
make install && \
apk del cmake automake libtool autoconf ninja bison && \
rm -rf /var/cache/apk/* && \
cd / && \
mkdir -p /var/run/h2o && \
touch /var/run/h2o/access-log /var/run/h2o/error-log

EXPOSE 8080

# H2O HTTP Server - Start server
CMD /h2o/h2o -c /etc/h2o/h2o.conf
