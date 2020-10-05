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
    var isPLaying = false
    
    var disposeBag: DisposeBag = DisposeBag()
    
    func setupCell(with videoEntity: VideoEntity) {
        doSetupIfNeed()
        self.videoEntity = videoEntity
    }
    
    func startTimer() {
        resetTimer()
        sourceObservable = Observable<Int>
            .interval(RxTimeInterval.milliseconds(250), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                guard let this = self, this.isPLaying else {
                    return
                }
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
        VideoThumbViewController.stopAllVideo.subscribe(onNext: { [weak self] _ in
            self?.pauseVideo()
            self?.videoEntity = nil
            self?.disposeBag = DisposeBag()
        }).disposed(by: disposeBag)
        isDidSetup = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pauseVideo()
    }
    
    func pauseVideo() {
        resetTimer()
        isPLaying = false
        if let ve = videoEntity {
            VideoManager.shared.setPlayTime(videoEntity: ve)
        }
    }
    
    func playVideo() {
        if let ve = videoEntity {
            isPLaying = true
            videoObj.replaceTheResources(ve.filePath)
            videoObj.seekTime(VideoManager.shared.getPlayTime(videoEntity: ve))
            startTimer()
        }
    }
}
