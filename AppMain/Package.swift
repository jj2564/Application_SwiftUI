// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

// MARK: - Product
let products: [Product] = [
    .library(name: "AppMain", targets: ["AppMain"]),
]

// MARK: - Dependency
let dependencies: [Package.Dependency] = [
    .package(path: "../Features"),
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture", exact: "1.17.1"),
    .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.4.0"),
]

// MARK: - Target
let tca: Target.Dependency = .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
let tca_dependencies: Target.Dependency = .product(name: "Dependencies", package: "swift-dependencies")

let targets: [Target] = [
    .target(
        name: "AppMain",
        dependencies: [
            .product(name: "AppEnvironments", package: "Features"),
            tca,
            tca_dependencies
        ]
    ),
    .testTarget(
        name: "AppMainTests",
        dependencies: [
            .target(name: "AppMain"),
            tca
        ]
    )
]

let package = Package(
    name: "AppMain",
    platforms: [.iOS(.v16)],
    products: products,
    dependencies: dependencies,
    targets: targets
)
