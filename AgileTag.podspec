#
# Be sure to run `pod lib lint YFPhotoAlbum.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "AgileTag"
  s.version          = "1.0"
  s.summary          = "Easy to add or remove tag with animation.."
  s.description      = <<-DESC
                       灵活的新增或者删除tag，支持cell上高度自动计算，tag标签自适应内容的长度等...
                       * Markdown format.
                       * Don't worry about the indent, we strip it!
                       DESC
  s.homepage         = "https://github.com/lovisty/AgileTag"
  s.license          = 'MIT'
  s.author           = { "Zhao Yafei" => "nihao1992@163.com" }
  s.source           = { :git => "https://github.com/lovisty/AgileTag.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'AgileTag/Classes/*.{h,m}'
  s.resources = "AgileTag/Assets/*.png"

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
end

