Pod::Spec.new do |s|
  s.name             = 'SwiftGradients'
  s.version          = '1.0.0'
  s.summary          = 'Color gradients for UIView and CALayer.'

  s.description      = 'SwiftGradients gives you useful extensions for UIViews and CALayer classes to add beautiful color gradients.'

  s.homepage         = 'https://github.com/rootstrap/SwiftGradients'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'German Lopez' => 'german@rootstrap.com' }
  s.source           = { :git => 'https://github.com/rootstrap/SwiftGradients.git',
                         :tag => s.version.to_s
                       }
  s.social_media_url = 'https://www.rootstrap.com/'
  
  s.ios.deployment_target = '9.3'

  s.source_files = 'Sources/**/*'
  s.frameworks = 'UIKit'
  s.swift_version = '5.2'
end
