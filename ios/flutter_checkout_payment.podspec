#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_checkout_payment.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_checkout_payment'
  s.version          = '0.0.1'
  s.summary          = 'This Flutter plugin is for Checkout.com online payment.'
  s.description      = <<-DESC
This Flutter plugin is for Checkout.com online payment with SPM support.
                       DESC
  s.homepage         = 'https://github.com/rohan20/flutter-checkout-payment-spm'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'rohan20' => 'rohan20@users.noreply.github.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  
  # Check if we're using SPM (Swift Package Manager)
  using_spm = ENV['USE_SPM_FOR_CHECKOUT'] == 'true'
  
  # Only add Frames CocoaPods dependency if we're NOT using SPM
  unless using_spm
    s.dependency 'Frames', '~> 4.0'
  end
  
  s.platform = :ios, '13.0'

  # Flutter.framework does not contain a i386 slice. Only x86_64 simulators are supported.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
  s.swift_version = '5.0'
end
