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
    
    /// Checkout API configuration
    private var publicKey: String!
    private var isProduction: Bool = false
    
    private var currentFlutterResult: FlutterResult? = nil
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: CHANNEL_NAME, binaryMessenger: registrar.messenger())
        let instance = SwiftFlutterCheckoutPaymentPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == METHOD_INIT {
            // Get the args from Flutter.
            guard let args = call.arguments as? [String: Any] else {
                return
            }
            
            let key : String = args["key"] as! String
            let environmentString : String = args["environment"] as! String
            
            publicKey = key
            isProduction = environmentString != "Environment.SANDBOX"
            
            // Return true if success.
            result(true)
        } else if call.method == METHOD_GENERATE_TOKEN {
            // Card tokenization not implemented in this bridge version
            // Apps should use the existing native CheckoutCardManagement framework
            result(FlutterError(code: "NOT_IMPLEMENTED", message: "Use CheckoutCardManagement SPM package directly for card tokenization", details: nil))
        } else if call.method == METHOD_GENERATE_APPLE_PAY_TOKEN {
            // Get the args from Flutter.
            let args = call.arguments as! [String: Any]
            let paymentDataBase64 : String = args["paymentDataBase64"] as! String
            
            // Create Apple Pay token via HTTP request to Checkout.com API
            self.createApplePayToken(paymentDataBase64: paymentDataBase64) { tokenResult in
                switch tokenResult {
                case .success(let tokenResponse):
                    result(tokenResponse)
                case .failure(let error):
                    result(FlutterError(code: self.GENERATE_TOKEN_ERROR, message: error, details: nil))
                }
            }
        } else if call.method == METHOD_IS_CARD_VALID {
            // Basic card validation not implemented in this bridge version
            result(false)
        } else if call.method == METHOD_HANDLE_3DS {
            // 3DS handling not implemented in this bridge version
            result(nil)
        } else {
            result(FlutterMethodNotImplemented)
        }
    }
    
    private func createApplePayToken(paymentDataBase64: String, completion: @escaping (Result<String, String>) -> Void) {
        let baseURL = isProduction ? "https://api.checkout.com" : "https://api.sandbox.checkout.com"
        guard let url = URL(string: "\(baseURL)/tokens") else {
            completion(.failure("Invalid API URL"))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(publicKey, forHTTPHeaderField: "Authorization")
        
        let requestBody: [String: Any] = [
            "type": "applepay",
            "token_data": [
                "data": paymentDataBase64
            ]
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
        } catch {
            completion(.failure("Failed to serialize request body: \(error.localizedDescription)"))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure("Network error: \(error.localizedDescription)"))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure("Invalid response"))
                return
            }
            
            guard let data = data else {
                completion(.failure("No response data"))
                return
            }
            
            if httpResponse.statusCode == 201 {
                // Success - parse the response
                do {
                    if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                        let tokenResponse = self.createTokenResponseString(from: json)
                        completion(.success(tokenResponse))
                    } else {
                        completion(.failure("Failed to parse response JSON"))
                    }
                } catch {
                    completion(.failure("JSON parsing error: \(error.localizedDescription)"))
                }
            } else {
                // Error response
                let errorMessage = String(data: data, encoding: .utf8) ?? "Unknown error"
                completion(.failure("API error (\(httpResponse.statusCode)): \(errorMessage)"))
            }
        }.resume()
    }
    
    private func createTokenResponseString(from json: [String: Any]) -> String {
        // Create a simplified response structure matching the expected format
        let response: [String: Any] = [
            "type": json["type"] ?? "applepay",
            "token": json["token"] ?? "",
            "expires_on": json["expires_on"] ?? "",
            "scheme": json["scheme"] ?? "",
            "last4": json["last4"] ?? "",
            "bin": json["bin"] ?? "",
            "card_type": json["card_type"] ?? "",
            "card_category": json["card_category"] ?? "",
            "issuer": json["issuer"] ?? "",
            "issuer_country": json["issuer_country"] ?? "",
            "product_id": json["product_id"] ?? "",
            "product_type": json["product_type"] ?? ""
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: response)
            return String(data: jsonData, encoding: .utf8) ?? "{}"
        } catch {
            return "{}"
        }
    }
}