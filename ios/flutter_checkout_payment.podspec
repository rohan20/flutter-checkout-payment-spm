Pod::Spec.new do |s|
  s.name             = 'flutter_checkout_payment'
  s.version          = '1.5.0'
  s.summary          = 'Checkout.com payment SDK for Flutter (Pure SPM)'
  s.description      = 'A minimal CocoaPods bridge - actual implementation provided by SPM Package.swift'
  s.homepage         = 'https://github.com/rohan20/flutter-checkout-payment-spm'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Rohan Taneja' => 'rhntnj@gmail.com' }

  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*'
  s.public_header_files = 'Classes/FlutterCheckoutPaymentPlugin.h'
  s.dependency 'Flutter'
  s.dependency 'Frames', '~> 4.3.8'
  
  # Note: This podspec only provides the Objective-C bridge
  # Swift implementation and dependencies are provided via SPM Package.swift
  
  s.platform = :ios, '13.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end