set -e

cd "$(dirname "$0")"

name=Ycode
codeName=Main
identifier=com.asentientbot.ycode

inPath="$PWD/$codeName.m"
appPath="$PWD/$name.app"

frameworkPath="/Applications/Xcode.app/Contents/SharedFrameworks"
frameworkFlags="-rpath $frameworkPath -F $frameworkPath -framework DVTKit -framework DVTFoundation"

rm -rf "$appPath"
mkdir -p "$appPath/Contents/MacOS"
mkdir -p "$appPath/Contents/Resources"

if [[ -z "$NO_UNIVERSAL" ]] ; then
    clang -fmodules -Wno-unused-getter-return-value -Wno-objc-missing-super-calls $frameworkFlags "$inPath" -o "$PWD/$name-amd64" -target x86_64-apple-macos10.13
    clang -fmodules -Wno-unused-getter-return-value -Wno-objc-missing-super-calls $frameworkFlags "$inPath" -o "$PWD/$name-arm64" -target arm64-apple-macos11
    lipo -create -output "$appPath/Contents/MacOS/$name" "$PWD/$name-amd64" "$PWD/$name-arm64"
    
    rm -rf "$PWD/$name-amd64"
    rm -rf "$PWD/$name-arm64"

else
    echo "Compatibility mode enabled!"
    if [[ $(uname -m) != "arm64" ]]; then
        clang -fmodules -Wno-unused-getter-return-value -Wno-objc-missing-super-calls $frameworkFlags "$inPath" -o "$appPath/Contents/MacOS/$name" -target x86_64-apple-macos10.13
    else
        clang -fmodules -Wno-unused-getter-return-value -Wno-objc-missing-super-calls $frameworkFlags "$inPath" -o "$appPath/Contents/MacOS/$name" -target arm64-apple-macos11
    fi
fi

plistPath="$appPath/Contents/Info.plist"
defaults write "$plistPath" CFBundleExecutable "$name"
defaults write "$plistPath" CFBundleName "$name"
defaults write "$plistPath" CFBundleIdentifier "$identifier"
defaults write "$plistPath" NSHighResolutionCapable -bool true
/usr/libexec/PlistBuddy "$plistPath" -c 'Add CFBundleDocumentTypes array'
/usr/libexec/PlistBuddy "$plistPath" -c 'Add CFBundleDocumentTypes:0 dict'
/usr/libexec/PlistBuddy "$plistPath" -c 'Add CFBundleDocumentTypes:0:CFBundleTypeRole string Editor'
/usr/libexec/PlistBuddy "$plistPath" -c 'Add CFBundleDocumentTypes:0:LSItemContentTypes array'
/usr/libexec/PlistBuddy "$plistPath" -c 'Add CFBundleDocumentTypes:0:LSItemContentTypes:0 string public.text'
/usr/libexec/PlistBuddy "$plistPath" -c 'Add CFBundleDocumentTypes:0:LSItemContentTypes:1 string public.data'
/usr/libexec/PlistBuddy "$plistPath" -c 'Add CFBundleDocumentTypes:0:NSDocumentClass string Document'
/usr/libexec/PlistBuddy "$plistPath" -c 'Add CFBundleDocumentTypes:0:CFBundleTypeName string document'
defaults write "$plistPath" CFBundleIconFile Icon.icns

cp Icon.icns "$appPath/Contents/Resources"

defaults delete $identifier
