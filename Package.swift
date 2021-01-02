// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "RxKingfisher",
  platforms: [
    .macOS(.v10_12), .iOS(.v10), .tvOS(.v10), .watchOS(.v3)
  ],
  products: [
    .library(
      name: "RxKingfisher",
      targets: ["RxKingfisher"]),
  ],
  dependencies: [
    .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "6.0.0" )),
    .package(url: "https://github.com/onevcat/Kingfisher.git", .upToNextMajor(from: "5.0.0" )),
  ],
  targets: [
    .target(
      name: "RxKingfisher",
      dependencies: ["RxSwift", .product(name: "RxCocoa", package: "RxSwift"), "Kingfisher"]),
    .testTarget(
      name: "RxKingfisherTests",
      dependencies: ["RxKingfisher"]),
  ]
)
