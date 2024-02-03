#!/bin/bash
set -x
set -e

dconf load /org/gnome/shell/ < ./shell-dconf-dump.txt