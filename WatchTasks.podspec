
Pod::Spec.new do |s|
  s.name             = "WatchTasks"
  s.version          = "1.0.0"
  s.summary          = "Client/Server implementation for WatchKit extensions."
  s.homepage         = "https://github.com/agustindc-rga/WatchTasks"
  s.license          = 'MIT'
  s.author           = { "Agustin de Cabrera" => "agustin.decabrera@rga.com" }
  s.source           = { :git => "https://github.com/agustindc-rga/WatchTasks.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'WatchTasks' => ['Pod/Assets/*.png']
  }
end
