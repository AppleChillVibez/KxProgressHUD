Pod::Spec.new do |spec|
  spec.name         = "KxProgressHUD"
  spec.version      = "1.0.0"
  spec.summary      = "A short description of KxProgressHUD. Swift 5, SVProgressHUD Swift版"
  spec.description  = <<-DESC
    A short description of KxProgressHUD. Swift 5, SVProgressHUD Swift版
                   DESC
  spec.homepage     = "https://github.com/xygkevin/KxProgressHUD"
  spec.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  spec.author             = { "许亚光" => "xu_yaguang@163.com" }
  spec.ios.deployment_target = "12.0"
  spec.source       = { :git => "https://github.com/xygkevin/KxProgressHUD.git", :tag => s.version.to_s }
  spec.source_files  = "Sources/KxProgressHUD/*.swift"
  spec.resources = "Sources/KxProgressHUD/Resources/KxProgressHUD.bundle"
  spec.frameworks = "UIKit", "Foundation"
  spec.requires_arc = true
  spec.swift_versions = ["5.3", "5.4", "5.5"]
  spec.xcconfig = { "VALID_ARCHS" => "x86_64 armv7 arm64" }

end
