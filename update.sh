#! /usr/bin/env nix-shell
#! nix-shell -i bash -p curl jq

UPDATES_URL="https://www.cursor.com/api/download?platform=linux-x64&releaseTrack=latest"

echo "Fetching updates from $UPDATES_URL"

RESPONSE=$(curl -sL $UPDATES_URL)
echo "Response: $RESPONSE"

APPIMAGE_URL=$(echo "$RESPONSE" | jq -r '.downloadUrl')
VERSION=$(echo "$RESPONSE" | jq -r '.version')

APPIMAGE_FILE="cursor.AppImage"
JSON_FILE="appimage.json"

# Download the AppImage
curl -sL -o $APPIMAGE_FILE $APPIMAGE_URL

# Calculate the SHA256 hash
APPIMAGE_HASH=$(sha256sum $APPIMAGE_FILE | awk '{ print $1 }')

# Save the URL and hash to a JSON file
echo "{\"appimage_url\": \"$APPIMAGE_URL\", \"sha256\": \"sha256:$APPIMAGE_HASH\", \"version\": \"$VERSION\"}" > $JSON_FILE

# Cleanup
rm $APPIMAGE_FILE