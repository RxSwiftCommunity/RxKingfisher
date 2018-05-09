//
//  ViewController.swift
//  Example
//
//  Created by Shai Mishali on 5/5/18.
//  Copyright © 2018 Shai Mishali. All rights reserved.
//

import UIKit
import RxKingfisher
import Kingfisher
import RxCocoa
import RxSwift
import Fakery

class ViewController: UIViewController {
    @IBOutlet private weak var image: UIImageView!
    @IBOutlet private weak var picker: UIPickerView!
    @IBOutlet private weak var btnSave: UIButton!
    @IBOutlet private weak var loader: UIActivityIndicatorView!

    private let disposeBag = DisposeBag()

    private var options: [String] {
        let faker = Faker()

        let names = (0...45)
                        .map { _ in faker.name.firstName().capitalized }

        return ["-- Select an Option --",
                "Hello!",
                "RxSwift Rules!",
                "How are you",
                ";-)"] + names
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupRx()
    }

    private func setupUI() {
        image.layer.borderColor = UIColor.black.cgColor
        image.layer.borderWidth = 4
    }

    private func setupRx() {
        Observable.just(options)
            .bind(to: picker.rx.itemTitles) { $1 }
            .disposed(by: disposeBag)

        let selectedOption = picker.rx.modelSelected(String.self)
            .map { $0.first! }
            .share()

        selectedOption
            .map { $0 != "-- Select an Option --" }
            .startWith(false)
            .bind(to: btnSave.rx.isEnabled)
            .disposed(by: disposeBag)

        // Example of binding a URL to the Kingfisher Rx extension
        selectedOption
            .startWith("Select Option")
            .map { $0 == "-- Select an Option" ? "Select Option" : $0 }
            .map { self.imgURL(withText: $0, andSize: self.image.bounds.size) }
            .bind(to: image.kf.rx.image(options: [.transition(.fade(0.2)),
                                                  .keepCurrentImageWhileLoading,
                                                  .forceTransition]))
            .disposed(by: disposeBag)

        // Example of retrieving an Image from a KingfisherManager
        // without being tied to a specific Image View.
        btnSave.rx.tap
            .do(onNext: { [weak self] in
                self?.btnSave.isHidden = true
                self?.loader.isHidden = false
            })
            .withLatestFrom(selectedOption)
            .map { self.imgURL(withText: $0, andSize: UIScreen.main.bounds.size) }
            .flatMapLatest { KingfisherManager.shared.rx.retrieveImage(with: $0) }
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] image in
                self?.btnSave.isHidden = false
                self?.loader.isHidden = true

                // Save image to Photo Library and redirect
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                UIApplication.shared.open(URL(string:"photos-redirect://")!)
            })
            .disposed(by: disposeBag)
    }

    private func imgURL(withText text: String, andSize size: CGSize) -> URL {
        return URL(string: "https://fakeimg.pl/\(Int(size.width))x\(Int(size.height))/?text=\(text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)&font=museo")!
    }
}
