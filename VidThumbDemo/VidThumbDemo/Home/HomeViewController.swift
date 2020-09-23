//
//  HomeViewController.swift
//  VidThumbDemo
//
//  Created by Ray Chow on 23/9/2020.
//

import Foundation
import RxSwift

class HomeViewController: VidThumbViewController<HomeViewInteractor, HomeViewPresenter, HomeViewRouter> {
    @IBOutlet weak var btnImport: UIButton!
 
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    let fileManager = FileManager.default
    override func setupRX() {
        super.setupRX()
        btnImport.rx.tap.subscribe { [weak self] _ in
            self?.presenter.openFileFolder()
        }.disposed(by: disposeBag)
    }
    
    override func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        presenter.saveNewFiles(with: urls)
    }
}
