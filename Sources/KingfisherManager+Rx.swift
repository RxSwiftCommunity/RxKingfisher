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
    public func retrieveImage(with source: Source,
                              options: KingfisherOptionsInfo? = nil) -> Single<Image> {
        return Single.create { [base] single in
            let task = base.retrieveImage(with: source,
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
    
    public func retrieveImage(with resource: Resource,
                              options: KingfisherOptionsInfo? = nil) -> Single<Image> {
        let source = Source.network(resource)
        return retrieveImage(with: source, options: options)
    }

}

extension KingfisherManager: ReactiveCompatible {
    public var rx: Reactive<KingfisherManager> {
        get { return Reactive(self) }
        set { }
    }
}
