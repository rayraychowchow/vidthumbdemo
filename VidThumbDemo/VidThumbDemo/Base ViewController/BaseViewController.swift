//
//  BaseViewController.swift
//  VidThumbDemo
//
//  Created by Ray Chow on 20/9/2020.
//

import Foundation
import UIKit
import RxSwift

class VidThumbViewController<I: BaseInteractor, P: BasePresenter<I, R>, R: BaseRouter>: BaseViewController {
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
    let disposeBag = DisposeBag()
    required init() {}
}

class BaseInteractor {
    required init() {}
}

class BaseRouter {
    required init() {}
}

class BaseViewController: UIViewController {

}

extension BaseViewController: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        
    }
}

extension BaseViewController: UIDocumentBrowserViewControllerDelegate {
    func documentBrowser(_ controller: UIDocumentBrowserViewController, didImportDocumentAt sourceURL: URL, toDestinationURL destinationURL: URL) {
        
    }
}
