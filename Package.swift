// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "pg-dump-repro-hb",
    platforms: [
        .macOS(.v10_15),
    ],
    dependencies: [
        .package(url: "https://github.com/hummingbird-project/hummingbird.git",
                 from: "0.0.0"),
        .package(url: "https://github.com/hummingbird-project/hummingbird-fluent.git", 
                 from: "0.1.0"),
        .package(url: "https://github.com/vapor/fluent-postgres-driver.git",
                 from: "2.0.0-rc"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .executableTarget(
            name: "Server",
            dependencies: [
                .product(name: "Hummingbird", package: "hummingbird"),
                .product(name: "HummingbirdFluent", package: "hummingbird-fluent"),
                .product(name: "HummingbirdFoundation", package: "hummingbird"),
                .product(name: "FluentPostgresDriver", package: "fluent-postgres-driver"),
            ]),
    ]
)
