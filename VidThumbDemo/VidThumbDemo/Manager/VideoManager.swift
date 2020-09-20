//
//  VideoManager.swift
//  VidThumbDemo
//
//  Created by Ray Chow on 20/9/2020.
//

import Foundation
import AVKit

class VideoManager {
    static let shared = VideoManager()
    var videosDic: [String: CMTime] = [:]
    
    func getPlayTime(videoEntity: VideoEntity) -> CMTime {
        return videosDic[videoEntity.fileName] ?? CMTime.zero
    }
    
    func setPlayTime(videoEntity: VideoEntity) {
        videosDic[videoEntity.fileName] = videoEntity.currentPlayTime
    }
}
