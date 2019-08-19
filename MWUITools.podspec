
Pod::Spec.new do |s|
  s.name             = 'MWUITools'
  s.version          = '1.0.0'
  s.summary          = 'A series of customed UI View or controller'

  s.description      = <<-DESC
A series of customed UI View or controller to use.
                       DESC

  s.homepage         = 'https://github.com/fishmwei/MWUITools'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'huangmingwei' => 'fishmwei@qq.com' }
  s.source           = { :git => 'https://github.com/fishmwei/MWUITools.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'MWUITools/Classes/**/*'
  
  # s.resource_bundles = {
  #   'MWUITools' => ['MWUITools/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
