// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

// MARK: - Dependency
let dependencies: [Package.Dependency] = [
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture", exact: "1.17.1"),
    .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.4.0"),
]

// MARK: - Target
let tca: Target.Dependency = .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
let tca_dependencies: Target.Dependency = .product(name: "Dependencies", package: "swift-dependencies")

let featuresTargets: [Target] = [
    .target(name: "Features",
            dependencies: [
                "AppEnvironment",
                tca
            ]),
    .testTarget(
        name: "FeaturesTests",
        dependencies: [
            .target(name: "Features"),
            tca
        ]
    )
]

let environmentTargets: [Target] = [
    .target(
        name: "AppEnvironment",
        dependencies: [
            tca_dependencies
        ]
    )
]

let targets: [Target] = featuresTargets + environmentTargets

// MARK: - Package
let package = Package(
    name: "Features",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "Features", targets: ["Features"]),
        .library(name: "AppEnvironment", targets: ["AppEnvironment"])
    ],
    dependencies: dependencies,
    targets: targets
)



