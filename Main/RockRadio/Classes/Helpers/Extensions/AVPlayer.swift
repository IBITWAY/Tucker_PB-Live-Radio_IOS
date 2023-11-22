//
//  AVPlayer.swift
//  RockRadio
//
//  Created by Faraz Rasheed on 11/08/2020.
//  Copyright © 2020 IBITWAY. All rights reserved.
//

import AVKit

import Foundation

extension AVPlayer {
    
    var isPlaying: Bool {
        if (self.rate != 0 && self.error == nil) {
            return true
        } else {
            return false
        }
    }
    
}

