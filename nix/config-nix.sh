#!/bin/bash
set -x
set -e

sudo cp -f ./configuration.nix  /etc/nixos/
sudo nixos-rebuild switch