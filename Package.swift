// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "SVGAPlayer",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "SVGAPlayer",
            targets: ["SVGAPlayer"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/ZipArchive/ZipArchive.git", exact: "2.4.2")
    ],
    targets: [
        .target(
            name: "Protobuf",
            path: "Vendor/ProtobufObjC",
            exclude: [
                "GPBProtocolBuffers.m",
                "GPBUnknownField+Additions.swift",
                "GPBUnknownFields+Additions.swift"
            ],
            publicHeadersPath: ".",
            cSettings: [
                .headerSearchPath("."),
                .unsafeFlags(["-fno-objc-arc"])
            ]
        ),
        .target(
            name: "SVGAProto",
            dependencies: ["Protobuf"],
            path: "Source/pbobjc",
            publicHeadersPath: ".",
            cSettings: [
                .headerSearchPath("."),
                .unsafeFlags(["-fno-objc-arc"])
            ]
        ),
        .target(
            name: "SVGAPlayer",
            dependencies: [
                "Protobuf",
                "SVGAProto",
                .product(name: "ZipArchive", package: "ZipArchive")
            ],
            path: "Source",
            exclude: ["pbobjc"],
            publicHeadersPath: ".",
            cSettings: [
                .headerSearchPath("."),
                .headerSearchPath("pbobjc")
            ],
            linkerSettings: [
                .linkedLibrary("z"),
                .linkedFramework("AVFoundation"),
                .linkedFramework("UIKit"),
                .linkedFramework("QuartzCore")
            ]
        )
    ]
)
