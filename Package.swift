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
        .package(url: "https://github.com/OperatorFoundation/Transmission", branch: "main"),
        .package(url: "https://github.com/OperatorFoundation/TransmissionData", branch: "main"),
    ],
    targets: [
        .target(
            name: "BigNumber",
            dependencies: [
                "Datable",
                "Transmission",
            ],
            path: "Sources"),
        .testTarget(
            name: "BigNumberTests",
            dependencies: [
                "BigNumber",
                "SwiftHexTools",
                "TransmissionData",
            ],
            path: "Tests"),
    ],
    swiftLanguageModes: [.v5]
)
