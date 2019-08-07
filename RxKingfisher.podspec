Pod::Spec.new do |s|
  s.name         = "RxKingfisher"
  s.version      = "0.6.0"
  s.summary      = "Reactive extension for the Kingfisher image downloading and caching library"
  s.description  = <<-DESC
    Reactive extension for the Kingfisher image downloading and caching library
  DESC
  s.homepage     = "https://github.com/RxSwiftCommunity/RxKingfisher"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Shai Mishali" => "freak4pc@gmail.com" }
  s.social_media_url   = "https://raw.githubusercontent.com/RxSwiftCommunity/RxKingfisher/master/Images/logo.png"
  s.source       = { :git => "https://github.com/RxSwiftCommunity/RxKingfisher.git", :tag => s.version.to_s }
  s.source_files  = "Sources/**/*"
  s.frameworks  = "Foundation"

  s.swift_version = "4.2"

  s.ios.deployment_target = "10.0"
  s.tvos.deployment_target = "10.0"
  s.osx.deployment_target = "10.12"

  s.dependency 'Kingfisher', '~> 5'
  s.dependency 'RxSwift', '~> 4.3'
  s.dependency 'RxCocoa', '~> 4.3'
end
