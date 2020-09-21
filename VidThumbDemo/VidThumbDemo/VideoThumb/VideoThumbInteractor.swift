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
    
    func getDemoVideos() -> Observable<[VideoEntity]> {
        return Observable.create { [weak self] observer in
            guard let this = self else { return Disposables.create{} }
            do {
                var documentList = try this.fileManager.contentsOfDirectory(atPath: Bundle.main.bundlePath)
                documentList.removeAll { !$0.hasSuffix(".avi") }
                
                var avAssets: [VideoEntity] = []
                
                for fileName in documentList {
                    if let videoPath = Bundle.main.path(forResource: fileName, ofType: nil) {
                        avAssets.append(VideoEntity(fileName: fileName, filePath: videoPath, asset: AVAsset(url: URL(fileURLWithPath: videoPath))))
                    }
                }
                
                observer.onNext(avAssets)
                observer.onCompleted()
                
            } catch {
                observer.onError(error)
            }
            return Disposables.create {}
        }
    }
}
