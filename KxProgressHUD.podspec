Pod::Spec.new do |s|
  s.name             = 'KxProgressHUD'
  s.version          = '1.0.0'
  s.summary          = 'A clean and lightweight progress HUD for iOS and tvOS app based on SVProgressHUD, written in Swift.'
  s.description  	    = <<-DESC
KxProgressHUD是一个轻量级便捷HUD工具，是SVProgressHUD的Swift版本，目前仅在iOS12以上系统版本经过测试；
                            DESC
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.homepage         = 'https://github.com/xygkevin/KxProgressHUD'
  s.swift_version    = "5.3"
  s.author           = { '许亚光' => 'xu_yaguang@163.com' }
  s.source           = { :git => 'https://github.com/xygkevin/KxProgressHUD.git', :tag => s.version.to_s }
  s.requires_arc 	    = true
  s.frameworks   	    = 'UIKit', 'Foundation'
  s.ios.deployment_target = '12.0'
  s.source_files = 'Sources/KxProgressHUD/*.swift'
  s.resources = 'Sources/KxProgressHUD/Resources/KxProgressHUD.bundle'
  s.swift_versions       = ['5.3', '5.4', '5.5']
  s.pod_target_xcconfig  = { 'VALID_ARCHS' => 'x86_64 armv7 arm64' }

end
