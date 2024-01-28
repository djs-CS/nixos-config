#!/bin/bash
set -x
set -e

sudo cp -Rf ./* /etc/nixos/
sudo nixos-rebuild switch