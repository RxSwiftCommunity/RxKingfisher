//
//  KingfisherManager+Rx.swift
//  RxKingfisher
//
//  Created by Shai Mishali on 5/5/18.
//  Copyright © 2018 RxSwift Community. All rights reserved.
//

import RxSwift
import Kingfisher

extension Reactive where Base == KingfisherManager {
    public func retrieveImage(with resource: Resource,
                              options: KingfisherOptionsInfo? = nil) -> Single<Image> {
        return Single<Image>.create { [base] single in
            let task = base.retrieveImage(
                with: resource,
                options: options,
                progressBlock: nil,
                completionHandler: { (result) in
                    switch result {
                    case let .failure(error):
                        single(.error(RxKingfisherError.kingfisherError(error)))
                    case let .success(value):
                        let image = value.image
                        single(.success(image))
                    }
            })

            return Disposables.create { task?.cancel() }
        }
    }
}

extension KingfisherManager: ReactiveCompatible {
    public var rx: Reactive<KingfisherManager> {
        get { return Reactive(self) }
        set { }
    }
}
