#!/usr/bin/env bash
set -euo pipefail
export DEBIAN_FRONTED=nointeractive
apt-get update
apt-get install -y bind9 bind9utils bind9-doc dnsutils
