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
    let avplayer = AVPlayer()
    let playerLayer = AVPlayerLayer()
    @IBOutlet weak var videoView: UIView!
    var isDidSetup = false
    var videoEntity: VideoEntity?
    
    func setupCell(with videoEntity: VideoEntity) {
        doSetupIfNeed()
        self.videoEntity = videoEntity
        let playItem = AVPlayerItem(asset: videoEntity.asset)
        avplayer.replaceCurrentItem(with: playItem)
        
        NotificationCenter.default.addObserver(self, selector:#selector(self.playerDidFinishPlaying(note:)),name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: avplayer.currentItem)
        
        playVideo()
    }
    
    func doSetupIfNeed() {
        guard !isDidSetup else { return }
        avplayer.isMuted = true
        playerLayer.player = avplayer
        playerLayer.frame = videoView.frame
        videoView.layer.addSublayer(playerLayer)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pauseVideo()
        
        NotificationCenter.default.removeObserver(self)
        avplayer.replaceCurrentItem(with: nil)
    }
    
    func pauseVideo() {
        avplayer.pause()
        if var ve = videoEntity {
            ve.currentPlayTime = avplayer.currentTime()
            VideoManager.shared.setPlayTime(videoEntity: ve)
        }
    }
    
    func playVideo() {
        if let ve = videoEntity, avplayer.rate == 0 {
            avplayer.seek(to: VideoManager.shared.getPlayTime(videoEntity: ve))
            avplayer.play()
        }
    }

    @objc func playerDidFinishPlaying(note: NSNotification){
        avplayer.seek(to: CMTime.zero)
        avplayer.play()
    }
}
