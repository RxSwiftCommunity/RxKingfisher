//
//  RxKingfisher.swift
//  RxKingfisher
//
//  Created by Shai Mishali on 5/5/18.
//  Copyright © 2018 RxSwift Community. All rights reserved.
//

import RxCocoa
import RxSwift
import Kingfisher

extension KingfisherWrapper {
    public struct Rx {
        private let wrapper: KingfisherWrapper<KFCrossPlatformImageView>
        
        init(_ base: KingfisherWrapper<KFCrossPlatformImageView>) {
            self.wrapper = base
        }

        public func image(placeholder: Placeholder? = nil,
                          options: KingfisherOptionsInfo? = nil) -> Binder<Resource?> {
            // `base.base` is the `Kingfisher` class' associated `ImageView`.
            return Binder(wrapper.base) { imageView, image in
                imageView.kf.setImage(with: image,
                                      placeholder: placeholder,
                                      options: options)
            }
        }
        
        public func setImage(with source: Source?,
                             placeholder: Placeholder? = nil,
                             options: KingfisherOptionsInfo? = nil) -> Single<KFCrossPlatformImage> {
            Single.create { [wrapper] single in
                let task = wrapper.setImage(
                    with: source,
                    placeholder: placeholder,
                    options: options,
                    completionHandler:  { result in
                        switch result {
                        case .success(let value):
                            single(.success(value.image))
                        case .failure(let error):
                            single(.failure(error))
                        }
                    }
                )
                
                return Disposables.create { task?.cancel() }
            }
        }
        
        public func setImage(with resource: Resource?,
                             placeholder: Placeholder? = nil,
                             options: KingfisherOptionsInfo? = nil) -> Single<KFCrossPlatformImage> {
            let source: Source?
            if let resource = resource {
                source = Source.network(resource)
            } else {
                source = nil
            }
            return setImage(with: source, placeholder: placeholder, options: options)
        }
    }
}

public extension KingfisherWrapper where Base == KFCrossPlatformImageView {
    var rx: KingfisherWrapper.Rx {
        .init(self)
    }
}
