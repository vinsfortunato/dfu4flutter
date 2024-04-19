#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint dfu4flutter.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'dfu4flutter'
  s.version          = '0.0.1'
  s.summary          = 'A wrapper around dfu-util for Flutter.'
  s.description      = <<-DESC
A new Flutter plugin project.
                       DESC
  s.homepage         = 'https://github.com/vinsfortunato/dfu4flutter'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'vinsfortunato' => 'vinsfortunato97@gmail.com' }

  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*'
  s.dependency 'FlutterMacOS'

  s.platform = :osx, '10.11'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version = '5.0'
end
