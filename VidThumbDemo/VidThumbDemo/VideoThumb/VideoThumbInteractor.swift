//
//  VideoThumbInteractor.swift
//  VidThumbDemo
//
//  Created by Ray Chow on 20/9/2020.
//

import Foundation
import RxSwift
import AVKit

class VideoThumbInteractor: BaseInteractor {
    let fileManager = FileManager.default
    
    func getDemoVideos() -> Single<[VideoEntity]> {
        return Single<[VideoEntity]>.create { [weak self] single in
            guard let this = self else { return Disposables.create{} }
            let path = this.fileManager.url(forUbiquityContainerIdentifier: nil)?.appendingPathComponent("videos").path ?? Bundle.main.bundlePath
            
            do {
                var documentList = try this.fileManager.contentsOfDirectory(atPath: path)
                
                documentList.removeAll { !$0.hasSuffix(".avi") }
                
                var avAssets: [VideoEntity] = []
                
                for fileName in documentList {
                    let videoPath = path + "/" + fileName
                    avAssets.append(VideoEntity(fileName: fileName, filePath: videoPath, asset: AVAsset(url: URL(fileURLWithPath: videoPath))))
                }
                single(.success(avAssets))
            } catch {
                single(.error(error))
            }
            return Disposables.create {}
        }
    }
}
