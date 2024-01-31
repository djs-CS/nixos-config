#!/bin/bash
set -x
set -e

temp_dir=$(mktemp -d)

# Ensure that the temporary directory is removed on script exit or interruption
trap "rm -rf $temp_dir" EXIT

# The URL of the GitHub repository to clone
repo_url="https://github.com/Fausto-Korpsvart/Catppuccin-GTK-Theme/"

# Clone the repository into the temporary directory
git clone $repo_url $temp_dir

cp -rf $temp_dir/themes/* ~/.themes

cp -rf $temp_dir/themes/Catppuccin-Macchiato-BL/gtk-4.0/* ~/.config/gtk-4.0/


mkdir -p ~/.icons
cp -rf $temp_dir/icons/* ~/.icons