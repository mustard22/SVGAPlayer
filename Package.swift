// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "SVGAPlayer",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "SVGAPlayer",
            targets: ["SVGAPlayer"]
        )
    ],
    dependencies: [
        // 👇 对应 Podspec: Protobuf
        .package(url: "https://github.com/apple/swift-protobuf.git", from: "1.37.0"),
        .package(url: "https://github.com/ZipArchive/ZipArchive.git", exact: "2.4.3")
    ],
    targets: [
        
        // ✅ ProtoFiles（对应 pbobjc）
        .target(
            name: "SVGAProto",
            path: "Source/pbobjc",
            publicHeadersPath: ".",
            cSettings: [
                .headerSearchPath("."),
                .define("GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS", to: "1")
            ],
            dependencies: [
                .product(name: "SwiftProtobuf", package: "swift-protobuf"),
                .product(name: "ZipArchive", package: "ZipArchive")
            ]
        ),
        
        // ✅ Core
        .target(
            name: "SVGACore",
            path: "Source",
            exclude: ["pbobjc"], // ❗避免重复编译
            publicHeadersPath: ".",
            cSettings: [
                .headerSearchPath("."),
                .headerSearchPath("pbobjc")
            ],
            dependencies: [
                "SVGAProto"
            ],
            linkerSettings: [
                .linkedFramework("AVFoundation"),
                .linkedLibrary("z")
            ]
        ),
        
        // ✅ 对外统一出口（类似 Pod 的默认 subspec）
        .target(
            name: "SVGAPlayer",
            dependencies: ["SVGACore"]
        )
    ]
)
