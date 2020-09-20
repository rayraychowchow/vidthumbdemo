//
//  BaseViewController.swift
//  VidThumbDemo
//
//  Created by Ray Chow on 20/9/2020.
//

import Foundation
import UIKit
import RxSwift

class BaseViewController<I: BaseInteractor, P: BasePresenter<I, R>, R: BaseRouter>: UIViewController {
    lazy var presenter = P()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupRX()
    }
    
    func setupUI() {}
    func setupRX() {}
}


class BasePresenter<I: BaseInteractor, R: BaseRouter> {
    internal lazy var interactor = I()
    internal lazy var router = R()
    required init() {}
}

class BaseInteractor {
    required init() {}
}

class BaseRouter {
    required init() {}
}
