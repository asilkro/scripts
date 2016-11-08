#!/bin/sh
# Getting package root path.
# Root path is given as $1 argument with bundle's path.
root_path="$1"
echo "Package root path: ${root_path}"

echo Currently installed profiles
sudo /usr/bin/profiles -L

echo installing wifi profile
sudo /usr/bin/profiles -I -F "${root_path}/Contents/Resources/WiFi.mobileconfig"

echo Currently installed profiles
sudo /usr/bin/profiles -L

exit 0
