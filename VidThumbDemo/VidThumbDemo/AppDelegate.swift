//
//  AppDelegate.swift
//  VidThumbDemo
//
//  Created by Ray Chow on 20/9/2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        DispatchQueue.global().async {
            let _ = FileManager.default.ubiquityIdentityToken
//            if let url = FileManager.default.url(forUbiquityContainerIdentifier: nil)?.appendingPathComponent("Demo Videos")
//            {
//                if !FileManager.default.fileExists(atPath: url.path) {
//
//                }
////                url.appendPathComponent("TEST0053.avi")
////                do {
////                    try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
////                    try FileManager.default.setUbiquitous(true, itemAt: url, destinationURL: url)
////                    try FileManager.default.startDownloadingUbiquitousItem(at: url)
////                } catch  {
////
////                }
//                UserDefaultManager.shared.saveDirectoryURL(url: url.path)
//            }
        }
        
        return true
    }
}

