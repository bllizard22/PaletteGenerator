// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PaletteGenerator",
    platforms: [.macOS(.v11)],
    dependencies: [
        .package(
            url: "https://github.com/stencilproject/Stencil.git",
            .upToNextMajor(from: "0.15.1")
        )
    ],
    targets: [
        .executableTarget(
            name: "PaletteGenerator",
            dependencies: [
                .product(name: "Stencil", package: "stencil")
            ])
    ]
)
