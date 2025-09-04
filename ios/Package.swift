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
        .package(url: "https://github.com/checkout/frames-ios", from: "4.3.8"),
        .package(url: "https://github.com/checkout/CheckoutCardManagement-iOS", from: "3.1.1"),
        .package(url: "https://github.com/checkout/checkout-event-logger-ios-framework", from: "1.2.4")
    ],
    targets: [
        .target(
            name: "flutter_checkout_payment",
            dependencies: [
                .product(name: "Frames", package: "frames-ios"),
                .product(name: "CheckoutCardManagement", package: "CheckoutCardManagement-iOS"),
                .product(name: "CheckoutEventLoggerKit", package: "checkout-event-logger-ios-framework")
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