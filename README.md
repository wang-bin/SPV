# SPV

[Download](https://sourceforge.net/projects/mdk-sdk/files/app/SPV.app.7z/download) from [github actions(artifacts)](https://github.com/wang-bin/SPV/actions) or [SF](https://sourceforge.net/projects/mdk-sdk/files/app/SPV.app.7z/download)

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

# TODO
QuickLook not file type association