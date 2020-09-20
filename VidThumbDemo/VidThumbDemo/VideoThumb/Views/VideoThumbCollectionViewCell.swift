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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        playerLayer.player = avplayer
        playerLayer.frame = videoView.bounds
        videoView.layer.addSublayer(playerLayer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(with playItem: AVPlayerItem) {
        
        avplayer.play()
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avplayer.pause()
        avplayer.replaceCurrentItem(with: nil)
    }
}
