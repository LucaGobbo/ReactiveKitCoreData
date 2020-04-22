#
# Be sure to run `pod lib lint ReactiveKitCoreData.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ReactiveKitCoreData'
  s.version          = '0.1.0'
  s.summary          = 'ReactiveKit + coredata'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
ReactiveKit + coredata, based on RxCoreData
                       DESC

  s.homepage         = 'https://github.com/LucaGobbo/ReactiveKitCoreData'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Luca Gobbo' => 'l.gobbo@me.com' }
  s.source           = { :git => 'https://github.com/LucaGobbo/ReactiveKitCoreData.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/lucagobbo'
  s.swift_versions = '5.2'
  s.ios.deployment_target = '8.0'

  s.source_files = 'Sources/ReactiveKitCoreData/**/*'
  


  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'ReactiveKit', '~> 3.16'
end
