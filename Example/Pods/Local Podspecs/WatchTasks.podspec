#
# Be sure to run `pod lib lint WatchTasks.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "WatchTasks"
  s.version          = "0.1.0"
  s.summary          = "Client/Server implementation for WatchKit extensions."
  s.homepage         = "https://gitlab.web.rga.com/ba-ios/watch-tasks"
  s.license          = 'MIT'
  s.author           = { "Agustin de Cabrera" => "agustin.decabrera@rga.com" }
  s.source           = { :git => "https://gitlab.web.rga.com/ba-ios/watch-tasks.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'WatchTasks' => ['Pod/Assets/*.png']
  }
end
