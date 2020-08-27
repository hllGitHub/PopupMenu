#
#  Be sure to run `pod spec lint PopMenu.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|
  spec.name         = "HLPopMenu"
  spec.version      = "0.0.1"
  spec.summary      = "A short description of PopMenu."
  spec.description  = "仿微信右上角弹出框"

  spec.homepage     = "https://github.com/hllGitHub/PopupMenu"
  spec.license      = "Apache License"

  spec.author             = { "liangliang.hu" => "hllfj922@gmail.com" }

  spec.module_name = 'HLPopMenu'
  spec.platform     = :ios, "11.0"

  spec.source       = { :git => "git@github.com:hllGitHub/PopupMenu.git", :tag => "#{spec.version}" }
  spec.source_files  = "Source/*.swift"
end
