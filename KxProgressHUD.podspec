Pod::Spec.new do |spec|

  spec.name         	    = 'KxProgressHUD'
  spec.version      	    = '2.0.0'
  spec.summary      	    = 'iOS导航栏工具，Swift版'
  spec.description  	    = <<-DESC
KxSwiftNavigation是一个导航栏工具，是HBDNavigationBar的Swift版本，目前仅在iOS12以上系统版本经过测试；
                            DESC
  spec.homepage     	    = 'https://github.com/xygkevin/KxProgressHUD.git'
  spec.license      	    = { :type => 'MIT', :file => 'LICENSE' }
  spec.author       	    = { '许亚光' => 'xu_yaguang@163.com' }
  spec.source       	    = { :git => 'https://github.com/xygkevin/KxProgressHUD.git', :tag => spec.version.to_s }
  spec.source_files         = 'Sources/KxProgressHUD/*.swift'
  spec.resources            = 'Sources/KxProgressHUD/Resources/KxProgressHUD.bundle'
  spec.frameworks   	    = 'UIKit', 'Foundation'
  spec.requires_arc 	    = true
  spec.swift_versions       = ['5.9']
  spec.ios.deployment_target = '13.0'
  spec.pod_target_xcconfig  = { 'VALID_ARCHS' => 'x86_64 armv7 arm64' }

end
