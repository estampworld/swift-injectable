// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "Injectable",
    platforms: [.macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6), .macCatalyst(.v13)],
    products: [
        .library(
            name: "Injectable",
            targets: ["Injectable"]
        ),
        .executable(
            name: "InjectableClient",
            targets: ["InjectableClient"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-syntax", "509.0.0"..<"510.0.0")
    ],
    targets: [
        .macro(
            name: "InjectableMacros",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
            ]
        ),
        .target(name: "Injectable", dependencies: ["InjectableMacros"]),
        .executableTarget(name: "InjectableClient", dependencies: ["Injectable"]),
        .testTarget(
            name: "InjectableTests",
            dependencies: ["Injectable"]),
    ]
)
