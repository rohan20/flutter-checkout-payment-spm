import Flutter
import UIKit

public class SwiftFlutterCheckoutPaymentPlugin: NSObject, FlutterPlugin {
    
    /// The channel name which it's the bridge between Dart and SWIFT
    private static var CHANNEL_NAME : String = "shadyboshra2012/fluttercheckoutpayment"
    
    /// Methods name which detect which it called from Flutter.
    private var METHOD_INIT : String = "init"
    private var METHOD_GENERATE_TOKEN : String = "generateToken"
    private var METHOD_GENERATE_APPLE_PAY_TOKEN : String = "generateApplePayToken"
    private var METHOD_IS_CARD_VALID : String = "isCardValid"
    private var METHOD_HANDLE_3DS : String = "handle3DS"
    
    /// Error codes returned to Flutter if there's an error.
    private var GENERATE_TOKEN_ERROR : String = "2"
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: CHANNEL_NAME, binaryMessenger: registrar.messenger())
        let instance = SwiftFlutterCheckoutPaymentPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        // For now, return error for all methods since we can't access SPM modules
        // TODO: Implement native iOS bridge to main app's CheckoutCardManagement
        result(FlutterError(code: "MODULE_ACCESS_ERROR", message: "SPM modules not accessible from plugin. Use native iOS implementation.", details: nil))
    }
}