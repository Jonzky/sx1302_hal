FROM arm64v8/alpine:latest

RUN apk add --update-cache \
    build-base \
    i2c-tools \
    linux-headers

WORKDIR /src/sx1302

COPY . .

RUN make clean
RUN make -j 4


FROM arm64v8/alpine:latest

WORKDIR /opt/packet-forwarder

COPY --from=0 /src/sx1302/packet_forwarder . 
COPY --from=0 /src/sx1302/tools .
COPY --from=0 /src/sx1302/tools/reset_lgw.sh /opt/

COPY start.sh /opt

RUN apk add --update-cache \
    wget \
    nano \
    linux-tools \
    spi-tools

ENTRYPOINT ["sh", "/opt/start.sh"]
