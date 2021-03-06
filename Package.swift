// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ReactiveKitCoreData",
    platforms: [
        .macOS(.v10_12),
        .iOS(.v8),
        .tvOS(.v9),
        .watchOS(.v2)
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "ReactiveKitCoreData",
            targets: ["ReactiveKitCoreData"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/DeclarativeHub/ReactiveKit.git", from: "3.16.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "ReactiveKitCoreData",
            dependencies: ["ReactiveKit"]
        ),
        .testTarget(
            name: "ReactiveKitCoreDataTests",
            dependencies: ["ReactiveKitCoreData"]
        ),
    ]
)
