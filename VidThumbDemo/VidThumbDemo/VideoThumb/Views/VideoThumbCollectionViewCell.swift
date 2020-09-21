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
    var isDidSetup = false
    var videoEntity: VideoEntity?
    
    let player = DLGPlayer()
    
    func setupCell(with videoEntity: VideoEntity) {
        doSetupIfNeed()
        self.videoEntity = videoEntity
        player.open(videoEntity.filePath)
        
        NotificationCenter.default.addObserver(self, selector: #selector(notifyPlayerOpened), name: NSNotification.Name(rawValue: DLGPlayerNotificationOpened), object: nil)
//        [nc addObserver:self selector:@selector(notifyPlayerOpened:) name:DLGPlayerNotificationOpened object:self.player];
        
//        playVideo()
//        player.play()
    }
    
    func doSetupIfNeed() {
        guard !isDidSetup else { return }
//        avplayer.isMuted = true
//        playerLayer.player = avplayer
//        playerLayer.frame = videoView.frame
//        videoView.layer.addSublayer(playerLayer)
        
        if let playerView = player.playerView {
            videoView.addSubview(playerView)
            playerView.translatesAutoresizingMaskIntoConstraints = false
            playerView.topAnchor.constraint(equalTo: videoView.topAnchor).isActive = true
            playerView.bottomAnchor.constraint(equalTo: videoView.bottomAnchor).isActive = true
            playerView.leadingAnchor.constraint(equalTo: videoView.leadingAnchor).isActive = true
            playerView.trailingAnchor.constraint(equalTo: videoView.trailingAnchor).isActive = true
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
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
        if player.opened {
            player.play()
        }
    }
}
