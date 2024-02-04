#!/bin/bash
set -x
set -e

dconf dump /org/gnome/shell/ > shell-dconf-dump.txt