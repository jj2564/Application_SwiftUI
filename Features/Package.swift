// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let dependencies: [Package.Dependency] = [
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture", exact: "1.17.1"),
]

let featuresTargets: [Target] = [
    .target(
        name: "Features",
        dependencies: [
            .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        ]
    ),
    .testTarget(
        name: "FeaturesTests",
        dependencies: [
            .target(name: "Features"),
            .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        ]
    ),
]

let targets: [Target] = featuresTargets

let package = Package(
    name: "Features",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "Features",
            targets: ["Features"]
        ),
    ],
    dependencies: dependencies,
    targets: targets
)
