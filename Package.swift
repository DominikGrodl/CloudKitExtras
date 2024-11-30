// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "CloudKitExtras",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .tvOS(.v12),
        .visionOS(.v1),
        .watchOS(.v4)
    ],
    products: [
        .library(
            name: "CloudKitExtras",
            targets: ["CloudKitExtras"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/swiftlang/swift-syntax", exact: "509.0.0")
    ],
    targets: [
        .target(
            name: "CloudKitExtras",
            dependencies: [
                "CloudKitExtrasMacros"
            ]
        ),
        .testTarget(
            name: "CloudKitExtrasTests",
            dependencies: ["CloudKitExtras"]
        ),
        .macro(
            name: "CloudKitExtrasMacros",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
            ]
        )
    ]
)
