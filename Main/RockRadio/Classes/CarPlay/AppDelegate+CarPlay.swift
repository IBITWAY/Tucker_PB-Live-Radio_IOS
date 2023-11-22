//
//  AppDelegate+CarPlay.swift
//  SwiftRadio
//
//  Created by Fethi El Hassasna on 2019-02-02.
//  Copyright © 2019 matthewfecher.com. All rights reserved.
//

import Foundation
import MediaPlayer

// MARK: - CarPlay Setup

extension AppDelegate {
    
    func setupCarPlay() {
        playableContentManager = MPPlayableContentManager.shared()
        
        playableContentManager?.delegate = self
        playableContentManager?.dataSource = self
        
        playableContentManager?.reloadData()
        
//        playableContentManager
        
//        StationsManager.shared.addObserver(self)
    }
}

// MARK: - MPPlayableContentDelegate

extension AppDelegate: MPPlayableContentDelegate {
    
    func playableContentManager(_ contentManager: MPPlayableContentManager, initiatePlaybackOfContentItemAt indexPath: IndexPath, completionHandler: @escaping (Error?) -> Void) {
        
        DispatchQueue.main.async {
//            if indexPath.count == 2 {
//                let station = StationsManager.shared.stations[indexPath[1]]
//                StationsManager.shared.set(station: station)
                MPPlayableContentManager.shared().nowPlayingIdentifiers = ["\(appName)"]
//            }
            completionHandler(nil)
        }
    }
    
//    func beginLoadingChildItems(at indexPath: IndexPath, completionHandler: @escaping (Error?) -> Void) {
//        StationsManager.shared.fetch { result in
//            guard case .failure(let error) = result else {
//                completionHandler(nil)
//                return
//            }
//
//            completionHandler(error)
//        }
//    }
}

// MARK: - MPPlayableContentDataSource

extension AppDelegate: MPPlayableContentDataSource {
    
    func numberOfChildItems(at indexPath: IndexPath) -> Int {
        if indexPath.indices.count == 0 {
            return 1
        }
        
        return 1
    }
    
    func contentItem(at indexPath: IndexPath) -> MPContentItem? {
        
        if indexPath.count == 1 {
            // Tab section
            let item = MPContentItem(identifier: "Stations")
            item.title = "Stations"
            item.isContainer = true
            item.isPlayable = false
            item.artwork = MPMediaItemArtwork(boundsSize: #imageLiteral(resourceName: "carPlayTab").size, requestHandler: { _ -> UIImage in
                return #imageLiteral(resourceName: "sam logo")
            })
            return item
        } else if indexPath.count == 2 {
            
            // Stations section
//            let station = StationsManager.shared.stations[indexPath.item]
            
            let item = MPContentItem(identifier: "\(appName)")
            item.title = "\(appName)"
            item.subtitle = ""
            item.isPlayable = true
            item.isStreamingContent = true
            item.artwork = MPMediaItemArtwork(boundsSize: #imageLiteral(resourceName: "carPlayTab").size) { _ -> UIImage in
                return UIImage(named: "sam logo")!
            }
            
            
            return item
        } else {
            return nil
        }
    }
}

// MARK: - StationsManagerObserver

//extension AppDelegate: StationsManagerObserver {
//
//    func stationsManager(_ manager: StationsManager, stationsDidUpdate stations: [RadioStation]) {
//        playableContentManager?.reloadData()
//    }
//
//    func stationsManager(_ manager: StationsManager, stationDidChange station: RadioStation?) {
//        guard let station = station else {
//            playableContentManager?.nowPlayingIdentifiers = []
//            return
//        }
//
//        playableContentManager?.nowPlayingIdentifiers = [station.name]
//    }
//}
