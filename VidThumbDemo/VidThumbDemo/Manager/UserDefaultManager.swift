//
//  UserDefaultManager.swift
//  VidThumbDemo
//
//  Created by Ray Chow on 23/9/2020.
//

import Foundation

class UserDefaultManager {
    static let shared = UserDefaultManager()
    let directoryKey = "DIRECTORY"
    let userDefaults = UserDefaults.standard
    
    func getDirectoryURL() -> String? {
        return userDefaults.string(forKey: directoryKey)
    }
    
    func saveDirectoryURL(url: String?) {
        userDefaults.set(url, forKey: directoryKey)
    }
}
