# Clean dependencies
pnpm clean-deps

# Remove Expo-generated native project
rm -rf ios

# Remove Expo cache
rm -rf .expo

# Remove Watchman cache
watchman watch-del-all

# Remove Xcode DerivedData
rm -rf ~/Library/Developer/Xcode/DerivedData
