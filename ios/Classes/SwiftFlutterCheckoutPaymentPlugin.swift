import Flutter
import UIKit
import Frames
import CheckoutCardManagement
import CheckoutEventLoggerKit

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
    
    /// Checkout instance
    private var checkoutAPIClient: CheckoutAPIClient?
    
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
        guard let arguments = call.arguments as? [String: Any],
              let publicKey = arguments["publicKey"] as? String else {
            result(FlutterError(code: "INVALID_ARGUMENTS", message: "Missing publicKey", details: nil))
            return
        }
        
        let environment: Environment = arguments["environment"] as? String == "live" ? .live : .sandbox
        checkoutAPIClient = CheckoutAPIClient(publicKey: publicKey, environment: environment)
        result("initialized")
    }
    
    private func handleGenerateToken(call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let checkoutAPIClient = checkoutAPIClient else {
            result(FlutterError(code: "NOT_INITIALIZED", message: "Plugin not initialized", details: nil))
            return
        }
        
        guard let arguments = call.arguments as? [String: Any] else {
            result(FlutterError(code: "INVALID_ARGUMENTS", message: "Missing arguments", details: nil))
            return
        }
        
        // Create card from arguments
        let card = CkoCardTokenRequest(
            number: arguments["number"] as? String ?? "",
            expiryMonth: arguments["expiryMonth"] as? UInt ?? 0,
            expiryYear: arguments["expiryYear"] as? UInt ?? 0,
            cvv: arguments["cvv"] as? String,
            name: arguments["name"] as? String,
            billingAddress: nil,
            phone: nil
        )
        
        checkoutAPIClient.createCardToken(card: card) { tokenResult in
            DispatchQueue.main.async {
                switch tokenResult {
                case .success(let tokenResponse):
                    result(tokenResponse.token)
                case .failure(let error):
                    result(FlutterError(code: self.GENERATE_TOKEN_ERROR, message: error.localizedDescription, details: nil))
                }
            }
        }
    }
    
    private func handleGenerateApplePayToken(call: FlutterMethodCall, result: @escaping FlutterResult) {
        result(FlutterError(code: "NOT_IMPLEMENTED", message: "Apple Pay not implemented yet", details: nil))
    }
    
    private func handleIsCardValid(call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let arguments = call.arguments as? [String: Any],
              let number = arguments["number"] as? String else {
            result(false)
            return
        }
        
        let isValid = CardValidator.isValid(cardNumber: number)
        result(isValid)
    }
    
    private func handleHandle3DS(call: FlutterMethodCall, result: @escaping FlutterResult) {
        result(FlutterError(code: "NOT_IMPLEMENTED", message: "3DS not implemented yet", details: nil))
    }
}