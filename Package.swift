// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NetworkManager",
    defaultLocalization: "en",
    platforms: [.iOS(.v15), .macOS(.v12)],
    products: [
        .library(
            name: "NetworkManager",
            targets: ["NetworkManager"]),
    ],
    targets: [
        .target(
            name: "NetworkManager",
            path: "Sources/Network",
            resources: [.process("Resources")]
        ),
    ]
)
