//
// THIS APPLICATION WAS DEVELOPED BY IURII DOLOTOV
//
// IF YOU HAVE ANY QUESTIONS PLEASE DO NOT TO HESITATE TO CONTACT ME VIA MARKETPLACE OR EMAIL: utilityman.development@gmail.com
//
// THE AUTHOR REMAINS ALL RIGHTS TO THE PROJECT
//
// THE ILLEGAL DISTRIBUTION IS PROHIBITED
//

import Foundation
import UIKit

extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
}

extension UIColor {
    
    static let lightBlack = UIColor(red: 53.0/255.0, green: 58.0/255.0, blue: 62.0/255.0, alpha: 1.0)
    
    static let darkBlack = UIColor(red: 24.0/255.0, green: 25.0/255.0, blue: 29.0/255.0, alpha: 1.0)
    
    static let midBlack = UIColor(red: 38.0/255.0, green: 36.0/255.0, blue: 46.0/255.0, alpha: 1.0)
    
    static let mellowOrange = UIColor(hexString: "#B98B36")
//        UIColor(red: 219.0/255.0, green: 88.0/255.0, blue: 44.0/255.0, alpha: 1.0)
    
    static let tickYellow = UIColor(hexString: "#B98B36")
//        UIColor(red: 160.0/255.0, green: 134.0/255.0, blue: 52.0/255.0, alpha: 1.0)
    
    //227,162,26
    
    static let lightWhite = UIColor(red: 227.0/255.0, green: 162.0/255.0, blue: 26.0/255.0, alpha: 0.2)
    
    static let darkWhite = UIColor(red: 227.0/255.0, green: 162.0/255.0, blue: 26.0/255.0, alpha: 1.0)
    
    static let midWhite = UIColor(red: 227.0/255.0, green: 162.0/255.0, blue: 26.0/255.0, alpha: 0.6)
    
}
