//
//  ImageCache+Rx.swift
//  RxKingfisher-iOS
//
//  Created by Amit Kumar Swami on 4/3/19.
//  Copyright © 2019 RxSwift Community. All rights reserved.
//

import RxSwift
import Kingfisher

extension Reactive where Base: ImageCache {
    public func retrieveImageInDiskCache(
        forKey key: String,
        options: KingfisherOptionsInfo? = nil) -> Single<Image?> {
        return Single<Image?>.create { [base] single in
            base.retrieveImageInDiskCache(forKey: key, options: options) { result in
                switch result {
                case let .failure(error):
                    single(.error(error))
                case let .success(image):
                    single(.success(image))
                }
            }
            
            return Disposables.create()
        }
    }
}

extension ImageCache: ReactiveCompatible { }

