//
//  HomeViewPresenter.swift
//  VidThumbDemo
//
//  Created by Ray Chow on 23/9/2020.
//

import Foundation

class HomeViewPresenter: BasePresenter<HomeViewInteractor, HomeViewRouter> {
    
    func openFileFolder() {
        router.openFileFolder()
    }
    
    func saveNewFiles(with url: [URL]) {
        interactor.cleanAndSaveFiles(with: url)
    }
}
