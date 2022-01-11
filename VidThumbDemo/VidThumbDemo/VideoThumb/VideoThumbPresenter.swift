//
//  VideoThumbPresenter.swift
//  VidThumbDemo
//
//  Created by Ray Chow on 20/9/2020.
//

import Foundation
import RxSwift
import AVKit
import RxCocoa

class VideoThumbPresenter: BasePresenter<VideoThumbInteractor, BaseRouter> {
    let avAssets = BehaviorRelay<[VideoEntity]>(value: [])
    
    func getDemoVideos() {
        interactor.getDemoVideos().do(onSuccess: { [weak self] demoVideos in
            self?.avAssets.accept(demoVideos)
        }).subscribe().disposed(by: disposeBag)
    }
    
    func cleanVideos() {
        avAssets.accept([])
    }
}
