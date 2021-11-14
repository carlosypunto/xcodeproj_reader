// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "xcodeproj_reader",
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.0.0"),
    ],
    targets: [
        .executableTarget(
            name: "xcodeproj_reader",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ]),
        .testTarget(
            name: "xcodeproj_readerTests",
            dependencies: ["xcodeproj_reader"]),
    ]
)
