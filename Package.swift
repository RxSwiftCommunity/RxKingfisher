// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "RxKingfisher",
  platforms: [
    .macOS(.v10_14), .iOS(.v12), .tvOS(.v12), .watchOS(.v5)
  ],
  products: [
    .library(
      name: "RxKingfisher",
      targets: ["RxKingfisher"]),
  ],
  dependencies: [
    .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "6.0.0" )),
    .package(url: "https://github.com/onevcat/Kingfisher.git", .upToNextMajor(from: "7.0.0" )),
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
