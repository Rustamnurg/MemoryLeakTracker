#
# To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
# To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  
  s.name         = "MemoryLeakTracker"
  
  s.version      = "0.1"
  
  s.summary      = "Library for finding memory leaks"
  
  s.swift_version = '5.0'
  
  s.description  = "description: Library for finding memory leaks"
  
  s.homepage     = "https://github.com/Rustamnurg/MemoryLeakTracker"
  
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  
  s.author       = { "Nurgaliev Rustam" => "rustamiosdev@gmail.com" }
  
  s.platform     = :ios, "11.0"
  
  s.source       = { :git => "https://github.com/Rustamnurg/MemoryLeakTracker.git", :tag => "#{s.version}" }
  
  s.source_files = "Source/**/*"
  
end
