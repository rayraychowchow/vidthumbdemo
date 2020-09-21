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
    var videosDic: [String: Double] = [:]
    
    func getPlayTime(videoEntity: VideoEntity) -> Double {
        return videosDic[videoEntity.fileName] ?? 0.0
    }
    
    func setPlayTime(videoEntity: VideoEntity) {
        videosDic[videoEntity.fileName] = videoEntity.currentTime
    }
}
