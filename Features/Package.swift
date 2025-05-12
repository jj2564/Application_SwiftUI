// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

// MARK: - Product
let products: [Product] = [
    .library(name: "Features", targets: ["Features"]),
    .library(name: "AppEnvironments", targets: ["AppEnvironments"]),
    .library(name: "HttpServices", targets: ["HttpServices"]),
]

// MARK: - Dependency
let dependencies: [Package.Dependency] = [
    .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.4.0"),
    .package(url: "https://github.com/apple/swift-http-types.git", from: "1.0.0"),
]

// MARK: - Target
let tca_dependencies: Target.Dependency = .product(name: "Dependencies", package: "swift-dependencies")

let featuresTargets: [Target] = [
    .target(name: "Features",
            dependencies: [
                "AppEnvironments",
                "HttpServices",
            ]),
]

let environmentTargets: [Target] = [
    .target(
        name: "AppEnvironments",
        dependencies: [
            tca_dependencies
        ]
    )
]

let httpServerTargets: [Target] = [
    .target(
        name: "HttpServices",
        dependencies: [
            .product(name: "HTTPTypes", package: "swift-http-types"),
            .product(name: "HTTPTypesFoundation", package: "swift-http-types"),
            tca_dependencies,
        ]
    ),
]

let targets: [Target] = featuresTargets + environmentTargets + httpServerTargets

// MARK: - Package
let package = Package(
    name: "Features",
    platforms: [.iOS(.v16)],
    products: products,
    dependencies: dependencies,
    targets: targets
)
