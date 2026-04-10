#!/bin/bash

# Install a client certificate and key into macOS keychain
# Usage: ./install-client-cert.sh <path-to-cert> <path-to-key> [password] [keychain-path]
# Example: ./install-client-cert.sh /path/to/client.crt /path/to/client.key mycertpass
# Default keychain: ~/Library/Keychains/login.keychain-db
# Default password: (will prompt if not provided)

set -e

if [ $# -lt 2 ]; then
    echo "Usage: $0 <path-to-cert> <path-to-key> [password] [keychain-path]"
    echo "Example: $0 /path/to/client.crt /path/to/client.key mycertpass"
    echo "         $0 /path/to/client.crt /path/to/client.key mycertpass ~/Library/Keychains/login.keychain-db"
    exit 1
fi

CERT_PATH="$1"
KEY_PATH="$2"
PKCS12_PASSWORD="${3:-}"
KEYCHAIN_PATH="${4:-~/Library/Keychains/login.keychain-db}"

# Expand tilde in keychain path
KEYCHAIN_PATH="${KEYCHAIN_PATH/#\~/$HOME}"

# Verify certificate and key files exist
if [ ! -f "$CERT_PATH" ]; then
    echo "Error: Certificate file not found: $CERT_PATH"
    exit 1
fi

if [ ! -f "$KEY_PATH" ]; then
    echo "Error: Key file not found: $KEY_PATH"
    exit 1
fi

# Verify they're valid
if ! openssl x509 -in "$CERT_PATH" -noout 2>/dev/null; then
    echo "Error: Invalid certificate file: $CERT_PATH"
    exit 1
fi

if ! openssl pkey -in "$KEY_PATH" -noout 2>/dev/null; then
    echo "Error: Invalid key file: $KEY_PATH"
    exit 1
fi

# If no password provided, generate a temporary one
if [ -z "$PKCS12_PASSWORD" ]; then
    PKCS12_PASSWORD=$(openssl rand -base64 12)
    echo "Generated temporary password for PKCS12: $PKCS12_PASSWORD"
fi

# Create temporary PKCS12 file
TEMP_P12="/tmp/temp_client_cert_$$.p12"
trap "rm -f $TEMP_P12" EXIT

echo "Converting certificate and key to PKCS12 format..."
openssl pkcs12 -export \
    -out "$TEMP_P12" \
    -inkey "$KEY_PATH" \
    -in "$CERT_PATH" \
    -passout "pass:$PKCS12_PASSWORD"

echo "Importing into Keychain: $KEYCHAIN_PATH"
security import "$TEMP_P12" \
    -k "$KEYCHAIN_PATH" \
    -P "$PKCS12_PASSWORD" \
    -T /usr/bin/security

echo "✓ Client certificate installed successfully"
echo "Certificate and key are now available in your Keychain"
