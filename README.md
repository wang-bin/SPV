# SPV

[Download](https://sourceforge.net/projects/mdk-sdk/files/app/SPV.app.tar.xz/download)

Swift Video Player for macOS

- QuickLook plugin
- High performance
- HDR display
- Blackmagic RAW support
- Metal Accelerated
- [Cross platform playback core](https://github.com/wang-bin/mdk-sdk)

## Build

- git clone --recurse-submodules https://github.com/wang-bin/SPV.git
- pod update
- open SPV.xcworkspace in Xcode

or `xcodebuild -workspace SPV.xcworkspace -configuration Release -scheme SPV CONFIGURATION_BUILD_DIR=$PWD/out`