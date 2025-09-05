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
    
    /// Minimal bridge - checkout functionality handled natively in iOS app
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: CHANNEL_NAME, binaryMessenger: registrar.messenger())
        let instance = SwiftFlutterCheckoutPaymentPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case METHOD_INIT:
            handleInit(call: call, result: result)
        case METHOD_GENERATE_TOKEN:
            handleGenerateToken(call: call, result: result)
        case METHOD_GENERATE_APPLE_PAY_TOKEN:
            handleGenerateApplePayToken(call: call, result: result)
        case METHOD_IS_CARD_VALID:
            handleIsCardValid(call: call, result: result)
        case METHOD_HANDLE_3DS:
            handleHandle3DS(call: call, result: result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    private func handleInit(call: FlutterMethodCall, result: @escaping FlutterResult) {
        result(FlutterError(code: "SPM_BRIDGE", message: "CheckoutCardManagement v3.1.1 functionality implemented natively in iOS app", details: call.method))
    }
    
    private func handleGenerateToken(call: FlutterMethodCall, result: @escaping FlutterResult) {
        result(FlutterError(code: "SPM_BRIDGE", message: "CheckoutCardManagement v3.1.1 functionality implemented natively in iOS app", details: call.method))
    }
    
    private func handleGenerateApplePayToken(call: FlutterMethodCall, result: @escaping FlutterResult) {
        result(FlutterError(code: "SPM_BRIDGE", message: "CheckoutCardManagement v3.1.1 functionality implemented natively in iOS app", details: call.method))
    }
    
    private func handleIsCardValid(call: FlutterMethodCall, result: @escaping FlutterResult) {
        result(FlutterError(code: "SPM_BRIDGE", message: "CheckoutCardManagement v3.1.1 functionality implemented natively in iOS app", details: call.method))
    }
    
    private func handleHandle3DS(call: FlutterMethodCall, result: @escaping FlutterResult) {
        result(FlutterError(code: "SPM_BRIDGE", message: "CheckoutCardManagement v3.1.1 functionality implemented natively in iOS app", details: call.method))
    }
}