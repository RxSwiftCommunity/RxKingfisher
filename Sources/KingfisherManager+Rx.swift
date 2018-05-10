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
            let task = base.retrieveImage(with: resource,
                                          options: options,
                                          progressBlock: nil) { image, error, _, _ in
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
}

extension KingfisherManager: ReactiveCompatible {
    public var rx: Reactive<KingfisherManager> {
        get { return Reactive(self) }
        set { }
    }
}
