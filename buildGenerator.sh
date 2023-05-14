cd Project
swift build -c release --arch arm64 --arch x86_64
cp -f .build/apple/Products/Release/PaletteGenerator ../../PaletteGenerator
