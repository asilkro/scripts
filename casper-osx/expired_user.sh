## This script will only remove expired hashes from the User keychain, 
## and should be run by the user wanting their keychain cleared.
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
    security delete-certificate -Z $expired
    fi

exit 0 #success