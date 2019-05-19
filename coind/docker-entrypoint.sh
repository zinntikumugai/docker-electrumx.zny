#!/bin/sh
set -e

if [ $(echo "$1" | cut -c1) = "-" ]; then
  echo "$0: assuming arguments for bitzenyd"

  set -- bitzenyd "$@"
fi

if [ $(echo "$1" | cut -c1) = "-" ] || [ "$1" = "bitzenyd" ]; then
  mkdir -p "$BITCOIN_DATA"
  chmod 700 "$BITCOIN_DATA"
  chown -R bitcoin "$BITCOIN_DATA"

  echo "$0: setting data directory to $BITCOIN_DATA"

  set -- "$@" -datadir="$BITCOIN_DATA"
fi

if [ "$1" = "bitzenyd" ] || [ "$1" = "bitzeny-cli" ] || [ "$1" = "bitzeny-tx" ]; then
  echo $1 run
  exec su-exec bitcoin "$@"
fi

echo $1
exec su-exec bitcoin "$@"