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
//    let avplayer = AVPlayer()
//    let playerLayer = AVPlayerLayer()
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    var isDidSetup = false
    var videoEntity: VideoEntity?
    
    let videoObj = XYQMovieObject()
    var timer: Timer?
    var sourceObservable: Disposable?
    
    func setupCell(with videoEntity: VideoEntity) {
        doSetupIfNeed()
        self.videoEntity = videoEntity
        
        videoObj.replaceTheResources(videoEntity.filePath)
        videoObj.seekTime(0.0)
        
        startTimer()
        
//        [nc addObserver:self selector:@selector(notifyPlayerOpened:) name:DLGPlayerNotificationOpened object:self.player];
        
//        playVideo()
//        player.play()
    }
    
    func startTimer() {
        resetTimer()
//        timer = Timer(timeInterval: 1 / videoObj.fps, repeats: true, block: { _ in
//            if self.videoObj.stepFrame() {
//                self.resetTimer()
//            }
//            self.imageView.image = self.videoObj.currentImage
//        })
//        let second = (1 / videoObj.fps) * 1000
        sourceObservable = Observable<Int>
            .interval(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                guard let this = self else { return }
                if !this.videoObj.stepFrame() {
                    this.resetTimer()
                    return
                }
                this.imageView.image = this.videoObj.currentImage
            })
    }
    
    func resetTimer() {
        timer?.invalidate()
        timer = nil
        sourceObservable?.dispose()
    }
    
    func doSetupIfNeed() {
        guard !isDidSetup else { return }
        imageView.contentMode = .scaleAspectFit
//        avplayer.isMuted = true
//        playerLayer.player = avplayer
//        playerLayer.frame = videoView.frame
//        videoView.layer.addSublayer(playerLayer)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resetTimer()
        pauseVideo()
        
//        NotificationCenter.default.removeObserver(self)
//        avplayer.replaceCurrentItem(with: nil)
    }
    
    func pauseVideo() {
//        avplayer.pause()
//        if var ve = videoEntity {
//            ve.currentPlayTime = avplayer.currentTime()
//            VideoManager.shared.setPlayTime(videoEntity: ve)
//        }
//        player.pause()
    }
    
    func playVideo() {
//        if let ve = videoEntity, avplayer.rate == 0 {
//            avplayer.seek(to: VideoManager.shared.getPlayTime(videoEntity: ve))
//            avplayer.play()
//        }
    }
    
    @objc func notifyPlayerOpened() {
        
    }
}
