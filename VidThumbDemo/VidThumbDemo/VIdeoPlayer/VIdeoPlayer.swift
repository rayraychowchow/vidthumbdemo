////
////  VIdeoPlayer.swift
////  VidThumbDemo
////
////  Created by Ray Chow on 21/9/2020.
////
//
//import Foundation
//import RxSwift
//
//class VIdeoPlayer {
//    private let decoder = DLGPlayerDecoder()
//    private let backgroundThread = DispatchQueue.global()
//    private let renderThread = DispatchQueue.global()
//    private let uiThread = DispatchQueue.main
//    let videoIsReadyToPlay = PublishSubject<Bool>()
//    var vframes = Array()
//    let view = DLGPlayerView()
//    
//    init() {}
//    
//    func setVideo(path: String) {
//        backgroundThread.async {
//            do {
//                try self.decoder.open(path)
//                self.videoIsReadyToPlay.onNext(true)
//            } catch {
//                
//            }
//        }
//    }
//    
//    func playVideo() {
//        backgroundThread.async {
//            
//        }
//    }
//    
//    func render() {
//        let eof = decoder.isEOF
//        let noframes = decoder.hasVideo && vframes.isEmpty()
//        
//        if eof && noframes {
//            
//        } else {
//            // Render if has picture
//            if (decoder.hasPicture && vframes.count > 0) {
//                let frame = vframes[0];
//                view.contentSize = CGSizeMake(frame.width, frame.height)
//                vframes.removeFirst()
//                view.render(frame)
//            }
//            
//            if (vframes.isEmpty() || !decoder.hasVideo) {
//                renderThread.async {
//                    self.render()
//                }
//                return;
//            }
//            
//            var frame: DLGPlayerVideoFrame
//                long timeout = dispatch_semaphore_wait(self.vFramesLock, DISPATCH_TIME_NOW);
//                if (timeout == 0) {
//                    frame = self.vframes[0];
//                    vframes.removeFirst()
//                    dispatch_semaphore_signal(self.vFramesLock);
//                }
//            view render:frame
//        }
//    }
//    
//    - (void)render {
//        
//        // Check whether render is neccessary
//        
//        
//        // Render video
//        DLGPlayerVideoFrame *frame = nil;
//        {
//            long timeout = dispatch_semaphore_wait(self.vFramesLock, DISPATCH_TIME_NOW);
//            if (timeout == 0) {
//                frame = self.vframes[0];
//                self.mediaPosition = frame.position;
//                self.bufferedDuration -= frame.duration;
//                [self.vframes removeObjectAtIndex:0];
//                dispatch_semaphore_signal(self.vFramesLock);
//            }
//        }
//        [self.view render:frame];
//        
//        // Sync audio with video
//        double syncTime = [self syncTime];
//        NSTimeInterval t = MAX(frame.duration + syncTime, 0.01);
//
//        __weak typeof(self)weakSelf = self;
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(t * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [weakSelf render];
//        });
//    }
//    
//    - (void)play {
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [strongSelf render];
//            [strongSelf startFrameReaderThread];
//        });
//    }
//}
