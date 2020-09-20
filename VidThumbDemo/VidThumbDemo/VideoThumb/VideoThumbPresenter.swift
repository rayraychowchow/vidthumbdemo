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
    let avAssets = BehaviorRelay<[AVAsset]>(value: [])
    
    func setupAVSession() {
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
        } catch {
            
        }
    }
    
    func getDemoVideos() -> Observable<Bool> {
        return interactor.getDemoVideos().do{ [weak self] demoVideoAssets in
            self?.avAssets.accept(demoVideoAssets)
        }.map({ _ in true })
    }
}
