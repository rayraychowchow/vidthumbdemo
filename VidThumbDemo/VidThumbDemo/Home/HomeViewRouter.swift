//
//  HomeViewRouter.swift
//  VidThumbDemo
//
//  Created by Ray Chow on 23/9/2020.
//

import Foundation
import MobileCoreServices

class HomeViewRouter: BaseRouter {
    func openFileFolder(viewController: BaseViewController) {
        let documentPickerController = UIDocumentPickerViewController(documentTypes: [String(kUTTypeAVIMovie)], in: UIDocumentPickerMode.open)
        documentPickerController.delegate = viewController
        documentPickerController.allowsMultipleSelection = true
        viewController.present(documentPickerController, animated: true, completion: nil)
    }
}
