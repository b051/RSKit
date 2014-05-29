Pod::Spec.new do |s|
  s.name         = "RSKit"
  s.version      = "0.0.1"
  s.summary      = "A short description of RSKit."
  
  s.description  = <<-DESC
  It contains
  
  * SpriteKit helper classes
                   DESC
  
  s.homepage     = "http://github.com/b051/RSKit"
  s.license      = "MIT"
  s.author       = { "Rex Sheng" => "shengning@gmail.com" }
  s.source       = { :git => "https://github.com/b051/RSKit.git", :tag => s.version.to_s }
  
  s.requires_arc = true
  
  s.subspec 'SpriteKit' do |ss|
    ss.framework = "SpriteKit"
    ss.source_files = 'RSKit/SK*.{h,m}'
  end

end
