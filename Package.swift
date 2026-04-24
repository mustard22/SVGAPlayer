// swift-tools-version:5.7
// import PackageDescription

// let package = Package(
//     name: "SVGAPlayer",
//     platforms: [
//         .iOS(.v15)
//     ],
//     products: [
//         .library(
//             name: "SVGAPlayer",
//             targets: ["SVGAPlayer"]
//         )
//     ],
//     targets: [
//         .target(
//             name: "SVGAPlayer",
//             path: "Source",
//             publicHeadersPath: ".",
//             cSettings: [
//                 .headerSearchPath("."),
//                 .headerSearchPath("**")
//             ]
//         )
//     ]
// )

// swift-tools-version: 5.9
import PackageDescription
let package = Package(
    name: "SVGAPlayer",
    platforms: [
        .iOS("15.0")
    ],
    products: [
        .library(
            name: "SVGAPlayer",
            targets: ["SVGAPlayer"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/ZipArchive/ZipArchive.git", exact: "2.4.3")
    ],
    targets: [
        .target(
            name: "SVGAPlayer",
            dependencies: [
                .product(name: "ZipArchive", package: "ZipArchive")
            ],
            path: ".",
            exclude: [
                ".github",
                "Example",
                "SVGAPlayer.xcodeproj",
                "SVGAPlayer.xcworkspace",
                "Podfile",
                "Podfile.lock",
                "SVGAPlayer.podspec",
                "CHANGELOG.md",
                "readme.md",
                "readme.zh.md",
                ".gitignore"
            ],
            sources: [
                "Source",
                "Vendor/ProtobufObjC"
            ],
            publicHeadersPath: "Source",
            cSettings: [
                .headerSearchPath("Source"),
                .headerSearchPath("Source/pbobjc"),
                .headerSearchPath("Vendor/ProtobufObjC"),
                .define("GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS", to: "0")
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
