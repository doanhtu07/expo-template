# Resolve this app's directory so the script works regardless of the CWD it is sourced from
APP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Clean dependencies (removes every node_modules in the workspace + root lockfile)
pnpm --dir "$APP_DIR" clean-deps

# Remove Expo-generated native project
rm -rf "$APP_DIR/ios"

# Remove Expo cache
rm -rf "$APP_DIR/.expo"

# Remove Watchman cache
watchman watch-del-all

# Remove Xcode DerivedData
rm -rf ~/Library/Developer/Xcode/DerivedData
