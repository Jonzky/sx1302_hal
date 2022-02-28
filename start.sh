#!/bin/bash

CONFIG="/opt/config.json"

# If a url has been set use it, otherwise use the default
if [[ -z "${OVERRIDE_PKT_CONFIG_URL}" ]]; then
  echo "No custom config has been passed, so it will use the default one"
  cp /opt/packet-forwarder/global_conf.json.sx1250.EU868 $CONFIG
else
  wget -O $CONFIG \
      "${OVERRIDE_PKT_CONFIG_URL}"
fi

/opt/packet-forwarder/lora_pkt_fwd -c $CONFIG