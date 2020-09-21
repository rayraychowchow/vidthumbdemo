//
//  VideoEntity.swift
//  VidThumbDemo
//
//  Created by Ray Chow on 20/9/2020.
//

import Foundation
import AVKit

struct VideoEntity {
    let fileName: String
    let filePath: String
    let asset: AVAsset
    var currentPlayTime = CMTime.zero
}
