#!/bin/bash

# Install and trust a root CA certificate in macOS system keychain
# Usage: ./install-root-ca.sh <path-to-ca-cert>
# Example: ./install-root-ca.sh /path/to/myca.crt

set -e

if [ $# -eq 0 ]; then
    echo "Usage: $0 <path-to-ca-cert>"
    echo "Example: $0 /path/to/myca.crt"
    exit 1
fi

CERT_PATH="$1"

# Verify the certificate file exists
if [ ! -f "$CERT_PATH" ]; then
    echo "Error: Certificate file not found: $CERT_PATH"
    exit 1
fi

# Verify it's a valid certificate
if ! openssl x509 -in "$CERT_PATH" -noout 2>/dev/null; then
    echo "Error: Invalid certificate file: $CERT_PATH"
    exit 1
fi

echo "Installing and trusting root CA certificate: $CERT_PATH"
sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain "$CERT_PATH"

echo "✓ Root CA certificate installed and trusted successfully"
