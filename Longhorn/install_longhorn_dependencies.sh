#!/bin/bash
set -e

sudo mkdir -p /data/longhorn-storage
sudo apt-get update
sudo apt-get install -y nfs-common open-iscsi cryptsetup