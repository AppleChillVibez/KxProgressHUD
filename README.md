# KxProgressHUD

`KxProgressHUD` is a clean and easy-to-use HUD meant to display the progress of an ongoing task on iOS and tvOS. `KxProgressHUD` is based on [SVProgressHUD](https://github.com/SVProgressHUD/SVProgressHUD) and ported to Swift with the [help of Swiftify](https://medium.com/swiftify/converting-svprogresshud-to-swift-using-swiftify-27be1817b7f6),
with improvements like added thread safety and not using complier flag for use in iOS App Extension. 

If you are interested in learning more about the conversion process, please [checkout](https://medium.com/swiftify/converting-svprogresshud-to-swift-using-swiftify-27be1817b7f6).

![KxProgressHUD](https://www.mobintouch.com/wp-content/uploads/2019/05/SVProgressHUD.gif)

## Demo        

Try `KxProgressHUD` on [Appetize.io](https://appetize.io/app/hn358rg7zc8uyethqayub23h2c).


## Installation

### From CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C and Swift, which automates and simplifies the process of using 3rd-party libraries like `KxProgressHUD` in your projects. First, add the following line to your [Podfile](http://guides.cocoapods.org/using/using-cocoapods.html):

```ruby
pod 'KxProgressHUD'
```

If you want to use the latest features of `KxProgressHUD` use normal external source dependencies.

```ruby
pod 'KxProgressHUD', :git => 'https://github.com/Swiftify-Corp/KxProgressHUD.git'
```

This pulls from the `master` branch directly.

Second, install `KxProgressHUD` into your project:

```ruby
pod install
```

### From SwiftPM

Under your project from the `File` menu, go to `Swift Packages` and select `Add Package Dependency`

Enter the address of the repository for the package you wish to add.
- https://github.com/Swiftify-Corp/KxProgressHUD.git

After you hit `Next`, you’ll see another form. From here you’re able to specify which `version`, `branch`, or `commit hash` you’d like to add as a dependency.

After you click `Next`, Xcode will fetch the dependency. In this final window, make sure the package you want to add is checked and the target you wish to add it to is selected from the dropdown.

After you click Finish, you’ll see that the added package is now listed in the navigator under a new section titled `Swift Package Dependencies`.

#### To Remove the package

If you need to remove a SwiftPM package from your project, you can select the project at the top of the navigator, then look for the tab titled `Swift Packages`. (It’s next to `Build Settings`). 

## Usage

`KxProgressHUD` is created as a singleton (i.e. it doesn't need to be explicitly allocated and instantiated; you directly call `KxProgressHUD.method()`). It can be accessed from even the background thread.

**Use `KxProgressHUD` wisely! Only use it if you absolutely need to perform a task before taking the user forward. Bad use case examples: pull to refresh, infinite scrolling, sending message.**

Using `KxProgressHUD` in your app will usually look as simple as this (using Grand Central Dispatch):

```Swift
KxProgressHUD.show()
DispatchQueue.global(qos: .default).async(execute: {
// time-consuming task
KxProgressHUD.dismiss()
})
```

### Showing the HUD

You can show the status of indeterminate tasks using one of the following:

```Swift
class func show()
class func show(withStatus status: String?)
```

If you'd like the HUD to reflect the progress of a task, use one of these:

```Swift
class func show(progress: CGFloat)
class func show(progress: CGFloat, status: String?)
```

### Dismissing the HUD

The HUD can be dismissed using:

```Swift
class func dismiss()
class func dismissWithCompletion(_ completion: (() -> Void)?)
class func dismissWithDelay(_ delay: TimeInterval)
class func dismissWithDelay(_ delay: TimeInterval, completion: (() -> Void)?)
```

If you'd like to stack HUDs, you can balance out every show call using:

```
class func popActivity()
```

The HUD will get dismissed once the popActivity calls will match the number of show calls.

Or show a confirmation glyph before before getting dismissed a little bit later. The display time depends on `minimumDismissTimeInterval` and the length of the given string.

```Swift
class func showInfowithStatus(_ status: String?)
class func showSuccesswithStatus(_ status: String?)
class func showError(withStatus status: String?)
class func showImage(_ image: UIImage, status: String?)
```

## Customization

`KxProgressHUD` can be customized via the following methods:

```Swift
class func set(defaultStyle style: KxProgressHUDStyle) // default is KxProgressHUDStyle.light

class func set(defaultMaskType maskType: KxProgressHUDMaskType) // default is KxProgressHUDMaskType.none

class func set(defaultAnimationType type: KxProgressHUDAnimationType) // default is KxProgressHUDAnimationType.flat

class func set(containerView: UIView?) // default is window level

class func set(minimumSize: CGSize) // default is CGSize.zero, can be used to avoid resizing

class func set(ringThickness: CGFloat) // default is 2 pt

class func set(ringRadius : CGFloat) // default is 18 pt

class func setRing(noTextRingRadius radius: CGFloat) // default is 24 pt

class func set(cornerRadius: CGFloat) // default is 14 pt

class func set(borderColor color : UIColor) // default is nil

class func set(borderWidth width: CGFloat)  // default is 0

class func set(font: UIFont) // default is UIFont.preferredFont(forTextStyle: .subheadline)

class func set(foregroundColor color: UIColor) // default is nil

class func set(backgroundColor color: UIColor) // default is nil

class func set(backgroundLayerColor color: UIColor) // default is UIColor(white: 0, alpha: 0.4), only used for KxProgressHUDMaskType.custom

class func set(imageViewSize size: CGSize) // default is 28x28 pt

class func set(shouldTintImages: Bool) // default is true

class func set(infoImage image: UIImage) // default is the bundled info image provided by Freepik

class func setSuccessImage(successImage image: UIImage) // default is bundled success image from Freepik

class func setErrorImage(errorImage image: UIImage) // default is bundled error image from Freepik

class func set(viewForExtension view: UIView) // default is nil, only used for App Extension

class func set(graceTimeInterval interval: TimeInterval) // default is 5.0 seconds

class func set(maximumDismissTimeInterval interval: TimeInterval) // default is TimeInterval(CGFloat.infinity)

class func setFadeInAnimationDuration(fadeInAnimationDuration duration: TimeInterval) // default is 0.15 seconds

class func setFadeOutAnimationDuration(fadeOutAnimationDuration duration: TimeInterval) // default is 0.15 seconds

class func setMaxSupportedWindowLevel(maxSupportedWindowLevel windowLevel: UIWindow.Level) // default is UIWindowLevelNormal

class func setHapticsEnabled(hapticsEnabled: Bool) // default is NO
```

### Hint

As standard `KxProgressHUD` offers two preconfigured styles:

* `KxProgressHUDStyle.light`: White background with black spinner and text
* `KxProgressHUDStyle.dark`: Black background with white spinner and text

If you want to use custom colors use `setForegroundColor` and `setBackgroundColor:`. These implicitly set the HUD's style to `KxProgressHUDStyle.custom`.

## Haptic Feedback

For users with newer devices (starting with the iPhone 7), `KxProgressHUD` can automatically trigger haptic feedback depending on which HUD is being displayed. The feedback maps as follows:

* `showSuccessWithStatus:` <-> `UINotificationFeedbackTypeSuccess`
* `showInfoWithStatus:` <-> `UINotificationFeedbackTypeWarning`
* `showErrorWithStatus:` <-> `UINotificationFeedbackTypeError`

To enable this functionality, use `setHapticsEnabled:`.

Users with devices prior to iPhone 7 will have no change in functionality.

## Notifications

`KxProgressHUD` posts four notifications via `NSNotificationCenter` in response to being shown/dismissed:
* `NotificationName.KxProgressHUDWillAppear` when the show animation starts
* `NotificationName.KxProgressHUDDidAppear` when the show animation completes
* `NotificationName.KxProgressHUDDidDisappear` when the dismiss animation starts
* `NotificationName.KxProgressHUDDidAppear` when the dismiss animation completes

Each notification passes a `userInfo` dictionary holding the HUD's status string (if any), retrievable via `[NotificationName.KxProgressHUDStatusUserInfoKey.getNotificationName()]`.

`KxProgressHUD` also posts `KxProgressHUDDidReceiveTouchEvent` when users touch on the overall screen or `KxProgressHUDDidTouchDownInside` when a user touches on the HUD directly. For this notifications `userInfo` is not passed but the object parameter contains the `UIEvent` that related to the touch.

## App Extensions

When using `KxProgressHUD` in an App Extension,  use the `class func set(viewForExtension view: UIView)` there is no need to set any complier flag.  

## Contributing to this project

If you have feature requests or bug reports, feel free to help out by sending pull requests or by [creating new issues](https://github.com/ibrahimhass/KxProgressHUD/issues/new). Please take a moment to
review the guidelines written by [Nicolas Gallagher](https://github.com/necolas):

* [Bug reports](https://github.com/necolas/issue-guidelines/blob/master/CONTRIBUTING.md#bugs)
* [Feature requests](https://github.com/necolas/issue-guidelines/blob/master/CONTRIBUTING.md#features)
* [Pull requests](https://github.com/necolas/issue-guidelines/blob/master/CONTRIBUTING.md#pull-requests)

## License

`KxProgressHUD` is distributed under the terms and conditions of the [MIT license](https://github.com/Swiftify-Corp/KxProgressHUD/blob/master/LICENSE). The success, error and info icons are made by [Freepik](http://www.freepik.com) from [Flaticon](http://www.flaticon.com) and are licensed under [Creative Commons BY 3.0](http://creativecommons.org/licenses/by/3.0/).

## Credits

`KxProgressHUD` is brought to you by [Md Ibrahim Hassan](https://github.com/Ibrahimhass) and [contributors to the project](https://github.com/Swiftify-Corp/KxProgressHUD/graphs/contributors).
If you're using `KxProgressHUD` in your project, attribution would be very appreciated. This project is converted with the help of [Swiftify](https://swiftify.com/).
