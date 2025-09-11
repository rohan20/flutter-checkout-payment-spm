// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "flutter_checkout_payment",
    platforms: [
        .iOS("13.0")
    ],
    products: [
        .library(name: "flutter_checkout_payment", targets: ["flutter_checkout_payment", "flutter_checkout_payment_objc"])
    ],
    dependencies: [
        .package(url: "https://github.com/checkout/frames-ios.git", from: "4.3.6")
    ],
    targets: [
        .target(
            name: "flutter_checkout_payment",
            dependencies: [
                .product(name: "Frames", package: "frames-ios")
            ],
            path: "Classes",
            sources: [
                "SwiftFlutterCheckoutPaymentPlugin.swift",
                "CardTokenisationResponse.swift"
            ],
            cSettings: [
                .define("FLUTTER_PLUGIN_REGISTRAR", to: "1")
            ]
        ),
        .target(
            name: "flutter_checkout_payment_objc",
            dependencies: ["flutter_checkout_payment"],
            path: "Classes",
            sources: [
                "FlutterCheckoutPaymentPlugin.m"
            ],
            publicHeadersPath: ".",
            cSettings: [
                .define("FLUTTER_PLUGIN_REGISTRAR", to: "1")
            ]
        )
    ]
)