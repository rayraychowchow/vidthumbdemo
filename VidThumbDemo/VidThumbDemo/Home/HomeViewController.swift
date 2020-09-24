//
//  HomeViewController.swift
//  VidThumbDemo
//
//  Created by Ray Chow on 23/9/2020.
//

import Foundation
import RxSwift

class HomeViewController: HomeBaseVidThumbViewController<HomeViewInteractor, HomeViewPresenter, HomeViewRouter> {
    @IBOutlet weak var btnImport: UIButton!
 
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    let fileManager = FileManager.default
    override func setupRX() {
        super.setupRX()
        btnImport.rx.tap.subscribe { [weak self] _ in
            guard let this = self else { return }
            this.presenter.openFileFolder(viewController: this)
        }.disposed(by: disposeBag)
    }
    
    override func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        presenter.saveNewFiles(with: urls)
    }
}

class HomeBaseVidThumbViewController<I: BaseInteractor, P: BasePresenter<I, R>, R: BaseRouter>: HomeBaseViewController {
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

class HomeBaseViewController: BaseViewController {
    @IBAction func unwindToHome(_ unwindSegue: UIStoryboardSegue) {}
}
