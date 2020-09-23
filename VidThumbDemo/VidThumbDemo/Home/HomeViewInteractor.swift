//
//  HomeViewInteractor.swift
//  VidThumbDemo
//
//  Created by Ray Chow on 23/9/2020.
//

import Foundation


class HomeViewInteractor: BaseInteractor {
    
    func cleanAndSaveFiles(with urls: [URL]) {
        if let url = FileManager.default.url(forUbiquityContainerIdentifier: nil) {
            do {
                try FileManager.default.removeItem(atPath: url.path)
                try FileManager.default.createDirectory(at: url.appendingPathComponent("videos"), withIntermediateDirectories: true, attributes: nil)
                try urls.forEach({
                    let _ = $0.startAccessingSecurityScopedResource()
                    try FileManager.default.copyItem(atPath: $0.path, toPath: url.appendingPathComponent("videos").appendingPathComponent($0.lastPathComponent).path)
                    $0.stopAccessingSecurityScopedResource()
                })
            } catch {
                print("ascasc")
            }
            
        }
    }
}
