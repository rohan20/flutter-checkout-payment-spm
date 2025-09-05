// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "flutter_checkout_payment",
    platforms: [
        .iOS("13.0")
    ],
    products: [
        .library(name: "flutter_checkout_payment", targets: ["flutter_checkout_payment"])
    ],
    dependencies: [
        
    ],
    targets: [
        .target(
            name: "flutter_checkout_payment",
            dependencies: [
                
            ],
            path: "Classes",
            sources: [
                "SwiftFlutterCheckoutPaymentPlugin.swift",
                "FlutterCheckoutPaymentPlugin.m"
            ],
            publicHeadersPath: ".",
            cSettings: [
                .define("FLUTTER_PLUGIN_REGISTRAR", to: "1")
            ]
        )
    ]
)