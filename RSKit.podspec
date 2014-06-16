Pod::Spec.new do |s|
  s.name         = "RSKit"
  s.version      = "0.1.2"
  s.summary      = "RSKit: helper classes for SpriteKit and so on."
  
  s.description  = <<-DESC
  It contains
  
  * helper classes for SpriteKit
  * helper classes for UIKit
                   DESC
  
  s.homepage     = "http://github.com/b051/RSKit"
  s.license      = "MIT"
  s.author       = { "Rex Sheng" => "shengning@gmail.com" }
  s.source       = { :git => "https://github.com/b051/RSKit.git", :tag => s.version.to_s }
  
  s.requires_arc = true
  s.ios.deployment_target = "7.0"
  s.osx.deployment_target = "10.9"
  
  s.subspec 'SpriteKit' do |ss|
    ss.ios.deployment_target = '7.0'
    ss.osx.deployment_target = '10.9'
    ss.frameworks = "SpriteKit"
    ss.source_files = 'RSKit/SK*.{h,m}', 'RSKit/RS*Node.{h,m}'
  end
  
  s.subspec 'Foundation' do |ss|
    ss.source_files = 'RSKit/NS*.{h,m}'
  end
  
  s.subspec 'UIKit' do |ss|
    ss.platform = :ios
    ss.source_files = 'RSKit/UI*.{h,m}'
  end

end
