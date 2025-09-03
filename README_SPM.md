# Flutter Checkout Payment - SPM Support

This fork adds Swift Package Manager (SPM) support to the original flutter_checkout_payment plugin.

## SPM Usage

To use this plugin with SPM instead of CocoaPods:

1. Set the environment variable in your `Podfile`:
   ```ruby
   ENV['USE_SPM_FOR_CHECKOUT'] = 'true'
   ```

2. Add the Frames SDK via SPM in your iOS project:
   - Open your iOS project in Xcode
   - Go to File → Add Package Dependencies
   - Add: `https://github.com/checkout/frames-ios`

3. Use this forked plugin in your `pubspec.yaml`:
   ```yaml
   flutter_checkout_payment:
     git:
       url: https://github.com/rohan20/flutter-checkout-payment-spm.git
   ```

## Benefits

- **No CocoaPods/SPM conflicts**: Use pure SPM for Checkout dependencies
- **Latest versions**: Access to the newest Checkout SDK versions
- **Better compatibility**: Works with other SPM packages seamlessly

## Original Plugin

This is a fork of [flutter_checkout_payment](https://github.com/ShadyBoshra2012/flutter_checkout_payment) with SPM support added.