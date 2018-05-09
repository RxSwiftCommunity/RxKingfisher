Pod::Spec.new do |s|
  s.name         = "RxKingfisher"
  s.version      = "0.1"
  s.summary      = "Reactive extension for the Kingfisher image downloading and caching library"
  s.description  = <<-DESC
    Reactive extension for the Kingfisher image downloading and caching library
  DESC
  s.homepage     = "https://github.com/RxSwiftCommunity/RxKingfisher"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Shai Mishali" => "freak4pc@gmail.com" }
  s.social_media_url   = ""
  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.9"
  s.watchos.deployment_target = "2.0"
  s.tvos.deployment_target = "9.0"
  s.source       = { :git => "https://github.com/RxSwiftCommunity/RxKingfisher.git", :tag => s.version.to_s }
  s.source_files  = "Sources/**/*"
  s.frameworks  = "Foundation"

  s.dependency 'Kingfisher'
  s.dependency 'RxSwift'
end
