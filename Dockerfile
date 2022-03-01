FROM arm64v8/debian:bullseye-slim

RUN apt-get update && apt-get install -y \
  jq \
  build-essential \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /src/sx1302

COPY . .

RUN make clean
RUN make


FROM arm64v8/debian:bullseye-slim

WORKDIR /opt/packet-forwarder

COPY --from=0 /src/sx1302/packet_forwarder . 
COPY --from=0 /src/sx1302/tools .
COPY --from=0 /src/sx1302/tools/reset_lgw.sh /opt/

COPY start.sh /opt

RUN apt-get update && apt-get install -y \
  git \
  nano \
  wget \
  && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["bash", "/opt/start.sh"]