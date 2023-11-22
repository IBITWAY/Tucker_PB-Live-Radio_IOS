//
//  BaseNeumorphicView.swift
//  Neumorphism
//
//  Created by Akshansh Thakur on 21/07/20.
//  Copyright © 2020 Akshansh Thakur. All rights reserved.
//

import Foundation
import UIKit

class BaseNeumorphicView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        
        backgroundColor = UIColor.lightBlack
        layer.cornerRadius = bounds.width / 2.0
        
        makeOutwardNeomorphic()
        
    }
    
}
