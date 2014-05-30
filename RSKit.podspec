Pod::Spec.new do |s|
  s.name         = "RSKit"
  s.version      = "0.0.3"
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
  
  s.subspec 'SpriteKit' do |ss|
    ss.frameworks = "SpriteKit"
    ss.source_files = 'RSKit/SK*.{h,m}'
  end

end
