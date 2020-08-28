Pod::Spec.new do |spec|
  spec.name         = "JHPopMenu"
  spec.version      = "0.0.1beta"
  spec.summary      = "仿微信右上角弹出框"
  spec.description  = "这是一个轻量的库，仿微信右上角弹出框，会持续保持更新"

  spec.homepage     = "https://github.com/hllGitHub/PopupMenu"
  spec.license      = "MIT"

  spec.author       = { "liangliang.hu" => "hllfj922@gmail.com" }

  spec.module_name = 'JHPopMenu'
  spec.platform     = :ios, "10.0"
  spec.swift_versions = ['4', '5']

  spec.source       = { :git => "https://github.com/hllGitHub/PopupMenu.git", :tag => "#{spec.version}" }
  spec.source_files  = "Source/*.swift"
end
