Pod::Spec.new do |s|
  s.name             = 'flutter_checkout_payment'
  s.version          = '1.5.0'
  s.summary          = 'Checkout.com payment SDK for Flutter (SPM bridge)'
  s.description      = 'A bridge podspec to integrate SPM-only plugin with Flutter CocoaPods integration'
  s.homepage         = 'https://github.com/rohan20/flutter-checkout-payment-spm'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Rohan Relan' => 'rohanrelan20@gmail.com' }

  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*'
  s.dependency 'Flutter'
  
  # This podspec serves as a bridge for SPM integration
  # The actual functionality is provided via SPM packages
  
  s.platform = :ios, '13.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end