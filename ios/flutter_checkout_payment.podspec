Pod::Spec.new do |s|
  s.name             = 'flutter_checkout_payment'
  s.version          = '1.5.0'
  s.summary          = 'Checkout.com payment SDK for Flutter (SPM bridge)'
  s.description      = 'A minimal bridge podspec that defers to SPM implementation'
  s.homepage         = 'https://github.com/rohan20/flutter-checkout-payment-spm'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Rohan Relan' => 'rohanrelan20@gmail.com' }

  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*'
  s.public_header_files = 'Classes/FlutterCheckoutPaymentPlugin.h'
  s.dependency 'Flutter'
  
  # Add Checkout Frames as CocoaPods dependency
  s.dependency 'Frames', '~> 4.3.8'
  
  # This podspec uses CocoaPods for dependency management
  
  s.platform = :ios, '13.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end