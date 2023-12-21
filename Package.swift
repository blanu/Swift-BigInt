// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "BigNumber",
    platforms: [.macOS(.v14)],
    products: [
        .library(
            name: "BigNumber",
            targets: ["BigNumber"]),
    ],
    dependencies: [
        .package(url: "https://github.com/OperatorFoundation/Datable", branch: "main"),
        .package(url: "https://github.com/OperatorFoundation/SwiftHexTools", branch: "main"),
    ],
    targets: [
        .target(
            name: "BigNumber",
            dependencies: [
                "Datable",
            ],
            path: "Sources"),
        .testTarget(
            name: "BigNumberTests",
            dependencies: [
                "BigNumber",
                "SwiftHexTools",
            ],
            path: "Tests"),
    ],
    swiftLanguageVersions: [.v5]
)
