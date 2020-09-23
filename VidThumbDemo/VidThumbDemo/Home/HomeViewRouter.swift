//
//  HomeViewRouter.swift
//  VidThumbDemo
//
//  Created by Ray Chow on 23/9/2020.
//

import Foundation
import MobileCoreServices

class HomeViewRouter: BaseRouter {
    func openFileFolder() {
        if let vc = viewController {
            let documentPickerController = UIDocumentPickerViewController(documentTypes: [String(kUTTypeAVIMovie)], in: UIDocumentPickerMode.open)
            documentPickerController.delegate = vc
            documentPickerController.allowsMultipleSelection = true
            vc.present(documentPickerController, animated: true, completion: nil)
        }
    }
}
