// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "SwiftGradients",
  platforms: [.iOS(.v9)],
  products: [
    .library(name: "SwiftGradients", targets: ["SwiftGradients"]),
  ],
  targets: [
    .target(name: "SwiftGradients", dependencies: [], path: "Sources")
  ]
)
