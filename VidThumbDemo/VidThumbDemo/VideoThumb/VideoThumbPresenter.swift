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
    
    func getDemoVideos() -> Observable<Bool> {
        return interactor.getDemoVideos().do{ [weak self] demoVideos in
            self?.avAssets.accept(demoVideos)
        }.map({ _ in true })
    }
}
