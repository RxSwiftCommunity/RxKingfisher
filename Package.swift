// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "RxKingfisher",
    platforms: [
        .macOS(.v10_12), .iOS(.v10), .tvOS(.v10)
    ],
    products: [
        .library(
            name: "RxKingfisher",
            targets: ["RxKingfisher"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/ReactiveX/RxSwift.git",
            from: "5.0.0"
        ),
        .package(
            url: "https://github.com/onevcat/Kingfisher.git",
            from: "5.0.0"
        )
    ],
    targets: [
        .target(
            name: "RxKingfisher",
            dependencies: ["RxSwift", "RxCocoa", "Kingfisher"],
            path: "Sources"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
