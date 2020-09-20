//
//  VideoThumbCollectionViewCell.swift
//  VidThumbDemo
//
//  Created by Ray Chow on 20/9/2020.
//

import Foundation
import UIKit
import AVKit

class VideoThumbCollectionViewCell: UICollectionViewCell, CustomCellable {
    static var reuseId: String { return "VideoThumbCollectionViewCell" }
    let avplayer = AVPlayer()
    let playerLayer = AVPlayerLayer()
    @IBOutlet weak var videoView: UIView!
    var isDidSetup = false
    
    func setupCell(with asset: AVAsset) {
        doSetupIfNeed()
        
        let playItem = AVPlayerItem(asset: asset)
        avplayer.replaceCurrentItem(with: playItem)
        avplayer.play()
    }
    
    func doSetupIfNeed() {
        guard !isDidSetup else { return }
        playerLayer.player = avplayer
        playerLayer.frame = videoView.bounds
        videoView.layer.addSublayer(playerLayer)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avplayer.pause()
        
        avplayer.replaceCurrentItem(with: nil)
    }
}
