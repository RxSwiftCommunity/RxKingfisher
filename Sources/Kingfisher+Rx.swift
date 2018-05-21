//
//  RxKingfisher.swift
//  RxKingfisher
//
//  Created by Shai Mishali on 5/5/18.
//  Copyright © 2018 RxSwift Community. All rights reserved.
//

import RxSwift
import Kingfisher

extension Reactive where Base == Kingfisher<ImageView> {
    public func setImage(with resource: Resource?,
                         placeholder: Placeholder? = nil,
                         options: KingfisherOptionsInfo? = nil) -> Single<Image> {
        return Single<Image>.create { [base] single in
            let task = base.setImage(with: resource,
                                     placeholder: placeholder,
                                     options: options) { image, error, _, _ in
                if let error = error {
                    single(.error(RxKingfisherError.kingfisherError(error)))
                    return
                }

                guard let image = image else {
                    single(.error(RxKingfisherError.missingImage))
                    return
                }

                single(.success(image))
            }

            return Disposables.create { task.cancel() }
        }
    }

    public func image(placeholder: Placeholder? = nil,
                      options: KingfisherOptionsInfo? = nil) -> AnyObserver<Resource> {
        return AnyObserver.init(eventHandler: { [base] e in
            guard case .next(let resource) = e else { return }

            _ = base.rx.setImage(with: resource,
                                 placeholder: placeholder,
                                 options: options)
                       .subscribe()
        })
    }
}

extension Kingfisher: ReactiveCompatible {
    public var rx: Reactive<Kingfisher> {
        get { return Reactive(self) }
        set { }
    }
}
