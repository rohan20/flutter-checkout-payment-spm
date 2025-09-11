import Foundation

extension Foundation.Bundle {
    static let module: Bundle = {
        let mainPath = Bundle.main.bundleURL.appendingPathComponent("PhoneNumberKit_PhoneNumberKit.bundle").path
        let buildPath = "/private/tmp/flutter-checkout-payment-spm/ios/.build/arm64-apple-macosx/debug/PhoneNumberKit_PhoneNumberKit.bundle"

        let preferredBundle = Bundle(path: mainPath)

        guard let bundle = preferredBundle ?? Bundle(path: buildPath) else {
            // Users can write a function called fatalError themselves, we should be resilient against that.
            Swift.fatalError("could not load resource bundle: from \(mainPath) or \(buildPath)")
        }

        return bundle
    }()
}