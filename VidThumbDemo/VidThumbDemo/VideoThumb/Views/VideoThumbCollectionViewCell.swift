//
//  VideoThumbCollectionViewCell.swift
//  VidThumbDemo
//
//  Created by Ray Chow on 20/9/2020.
//

import Foundation
import UIKit
import AVKit
import RxSwift

class VideoThumbCollectionViewCell: UICollectionViewCell, CustomCellable {
    static var reuseId: String { return "VideoThumbCollectionViewCell" }
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    var isDidSetup = false
    var videoEntity: VideoEntity?
    
    let videoObj = XYQMovieObject()
    var sourceObservable: Disposable?
    
    func setupCell(with videoEntity: VideoEntity) {
        doSetupIfNeed()
        self.videoEntity = videoEntity
        
        playVideo()
    }
    
    func startTimer() {
        resetTimer()
        sourceObservable = Observable<Int>
            .interval(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                guard let this = self else { return }
                if !this.videoObj.stepFrame() {
                    this.videoObj.redialPaly()
                    return
                }
                this.imageView.image = this.videoObj.currentImage
                this.videoEntity?.currentTime = this.videoObj.currentTime
            })
    }
    
    func resetTimer() {
        sourceObservable?.dispose()
    }
    
    func doSetupIfNeed() {
        guard !isDidSetup else { return }
        imageView.contentMode = .scaleAspectFit
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pauseVideo()
    }
    
    func pauseVideo() {
        resetTimer()
        if var ve = videoEntity {
//            ve.currentTime = videoObj.currentTime
            VideoManager.shared.setPlayTime(videoEntity: ve)
        }
    }
    
    func playVideo() {
        if let ve = videoEntity {
            videoObj.replaceTheResources(ve.filePath)
            videoObj.seekTime(VideoManager.shared.getPlayTime(videoEntity: ve))
            startTimer()
        }
    }
    
    @objc func notifyPlayerOpened() {
        
    }
}
