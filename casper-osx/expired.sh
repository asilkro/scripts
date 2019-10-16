## This script will remove expired hashes from the System keychain
## and is built to run from a root account with access to the keychain (ie from JAMF)
## When complete, run again to validate that the item was removed.

#!/bin/bash
# Gather expired certificate hashes
expired=$(security find-identity | grep EXPIRED | awk '{print $2}')

# Check for expired certs in Keychain

if [ -z "$expired" ]
    then
        echo "No expired certificates found."
    else
    # Deletes the expired certs via their hash
    echo "Removing expired certificates."
    security delete-certificate -Z $expired /Library/Keychains/System.keychain
    fi

exit 0 #success