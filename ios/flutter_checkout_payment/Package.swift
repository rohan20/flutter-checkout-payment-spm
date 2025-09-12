// swift-tools-version: 5.9
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
        .package(url: "https://github.com/checkout/frames-ios.git", from: "4.3.8"),
        .package(url: "https://github.com/checkout/checkout-risk-sdk-ios.git", from: "3.0.4"),
        .package(url: "https://github.com/checkout/checkout-event-logger-ios-framework.git", from: "1.2.4"),
        .package(url: "https://github.com/fingerprintjs/fingerprintjs-pro-ios", from: "2.10.0")
    ],
    targets: [
        .target(
            name: "flutter_checkout_payment",
            dependencies: [
                .product(name: "Frames", package: "frames-ios"),
                .product(name: "Risk", package: "checkout-risk-sdk-ios"),
                .product(name: "CheckoutEventLoggerKit", package: "checkout-event-logger-ios-framework"),
                .product(name: "FingerprintPro", package: "fingerprintjs-pro-ios")
            ],
            path: "Classes",
            sources: [
                "SwiftFlutterCheckoutPaymentPlugin.swift",
                "CardTokenisationResponse.swift",
                "FlutterCheckoutPaymentPluginShim.swift"
            ]
        )
    ]
)
