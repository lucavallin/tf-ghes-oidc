#!/bin/bash

hostname=$1
if [ -z $hostname ]
then
    echo "No hostname provided. Usage: thumbprint.sh <GHES_HOSTNAME>"
    exit 0
fi

# Generate fingerprint with openssl
fingerprint=$(openssl s_client -connect $hostname:443 < /dev/null 2>/dev/null | openssl x509 -fingerprint -noout -sha1 -in /dev/stdin)

# Remove 'SHA1\nFingerprint=' part
cleaned_fingerprint=${fingerprint#"SHA1 Fingerprint="}
cleaned_fingerprint=${cleaned_fingerprint#"sha1 Fingerprint="}

# Remove all colons
thumbprint=${cleaned_fingerprint//:/}

# Print the output
echo "GHES Thumbprint: $thumbprint"
