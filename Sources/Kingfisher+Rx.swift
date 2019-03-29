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

extension Reactive where Base == KingfisherWrapper<ImageView> {
    public func setImage(with resource: Resource?,
                         placeholder: Placeholder? = nil,
                         options: KingfisherOptionsInfo? = nil) -> Single<Image> {
        return Single.create { [base] single in
            let task = base.setImage(with: resource,
                                     placeholder: placeholder,
                                     options: options) { result in
                switch result {
                case .success(let value):
                    single(.success(value.image))
                case .failure(let error):
                    single(.error(error))
                }
            }
            
            return Disposables.create { task?.cancel() }
        }
    }

    public func image(placeholder: Placeholder? = nil,
                      options: KingfisherOptionsInfo? = nil) -> Binder<Resource?> {
        // `base.base` is the `Kingfisher` class' associated `ImageView`.
        return Binder(base.base) { imageView, image in
            imageView.kf.setImage(with: image,
                                  placeholder: placeholder,
                                  options: options)
        }
    }

    public func image(placeholder: Placeholder? = nil,
                      options: KingfisherOptionsInfo? = nil) -> Binder<ImageDataProvider?> {
        // `base.base` is the `Kingfisher` class' associated `ImageView`.
        return Binder(base.base) { imageView, provider in
            imageView.kf.setImage(with: provider,
                                  placeholder: placeholder,
                                  options: options)
        }
    }
}

extension KingfisherWrapper: ReactiveCompatible { }
