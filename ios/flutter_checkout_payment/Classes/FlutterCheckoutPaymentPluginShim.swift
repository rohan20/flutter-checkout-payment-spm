import Flutter
import Foundation

@objc(FlutterCheckoutPaymentPlugin)
public class FlutterCheckoutPaymentPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        SwiftFlutterCheckoutPaymentPlugin.register(with: registrar)
    }
}
