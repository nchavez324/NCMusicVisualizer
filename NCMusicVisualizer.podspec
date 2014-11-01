#
# Be sure to run `pod lib lint NCMusicVisualizer.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "NCMusicVisualizer"
  s.version          = "0.1.0"
  s.summary          = "A Music Visualizer that takes in an AudioUnit-ish dataSource."
  s.homepage         = "https://github.com/nchavez324/NCMusicVisualizer"
  
  s.license          = 'MIT'
  s.author           = { "Nick Chavez" => "nchavez324@yahoo.com" }
  s.source           = { :git => "https://github.com/nchavez324/NCMusicVisualizer.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
  s.resource_bundles = {
    'NCMusicVisualizer' => ['Pod/Assets/*.png']
  }

  s.library = 'c++'
  s.xcconfig = {
       'CLANG_CXX_LANGUAGE_STANDARD' => 'c++11',
       'CLANG_CXX_LIBRARY' => 'libc++'
  }

  s.public_header_files = 'Pod/Classes/*.h'

end
