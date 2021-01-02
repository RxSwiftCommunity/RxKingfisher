<p align="center">
<img src="https://raw.githubusercontent.com/RxSwiftCommunity/RxKingfisher/main/Images/logo.png" alt="RxKingfisher" title="RxKingfisher" width="557"/>
</p>

<p align="center">
<a href="https://circleci.com/gh/RxSwiftCommunity/RxKingfisher/tree/main"><img src="https://img.shields.io/circleci/project/github/RxSwiftCommunity/RxKingfisher/main.svg?style=flat"></a>
<a href="https://github.com/Carthage/Carthage/"><img src="https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat"></a>
<a href="http://github.com/RxSwiftCommunity/RxKingfisher"><img src="https://img.shields.io/cocoapods/v/RxKingfisher.svg?style=flat"></a>
<a href="https://raw.githubusercontent.com/RxSwiftCommunity/RxKingfisher/main/LICENSE"><img src="https://img.shields.io/cocoapods/l/RxKingfisher.svg?style=flat"></a>
<a href="http://github.com/RxSwiftCommunity/RxKingfisher"><img src="https://img.shields.io/cocoapods/p/RxKingfisher.svg?style=flat"></a>
</p>

**RxKingfisher** is a Reactive Extension for <a href="https://github.com/onevcat/Kingfisher" target="_blank">Kingfisher</a> - a lightweight, pure-Swift library for downloading and caching images from the web. 

<p align="center"><img src="https://raw.githubusercontent.com/RxSwiftCommunity/RxKingfisher/main/Images/example.gif" alt="RxKingfisher Example" title="RxKingfisher Example" /></a>

It provides Reactive Extensions on top of Kingfisher's `.kf` namespace, via `.kf.rx` and introduces two main usages:

#### Bind URL to Image View by `Resource` or `Source`

Every Image view supports two different options for binding a URL to an Image view.

```swift 
optionSelected // Observable<Resource> or Observable<Source>
    .bind(to: image.kf.rx.image(options: [.transition(.fade(0.2))])
    .disposed(by: disposeBag)
```

OR

```swift
optionSelected // Observable<Resource> or Observable<Source>    
    .flatMap { url in imageView.kf.rx.setImage(with: url, options: [.transition(.fade(0.2))]) }
    .subscribe(onNext: { image in
        print("Image successfully loaded and set on Image view: \(image)")
    })
    .disposed(by: disposeBag)
```
> ### Refer
> `URL` is implementing `Resource` (See [Kingfisher.Resource.swift](https://github.com/onevcat/Kingfisher/blob/c598ab7a7b3f3a4778ab18076b3449a30fc8c0d3/Sources/General/ImageSource/Resource.swift#L71-L74))


### Retrieve an Image without an Image View

Every `KingfisherManager` supports fetching an image from a URL, returning a `Single<Image>`:

```swift
tappedButton
    .flatMapLatest { KingfisherManager.shared.rx.retrieveImage(with: urlToImage) }
    .subscribe(onNext: { image in
        print("Image successfully loaded: \(image)")
    })
    .disposed(by: disposeBag)
```

### License

RxKingfisher is released under the MIT license. See LICENSE for details.
