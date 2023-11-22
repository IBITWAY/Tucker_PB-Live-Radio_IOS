//
//  UIView.swift
//  RockRadio
//
//  Created by Faraz Rasheed on 11/08/2020.
//  Copyright © 2020 IBITWAY. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableView: UIView
{
    
}

@IBDesignable
class DesignableButton: UIButton
{
    
}

extension UIView
{
    @IBInspectable
    var cornerRadius: CGFloat
    {
        get
        {
            return layer.cornerRadius
        }
        set
        {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat
    {
        get
        {
            return layer.borderWidth
        }
        set
        {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor?
    {
        get
        {
            if let color = layer.borderColor
            {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set
        {
            if let color = newValue
            {
                layer.borderColor = color.cgColor
            } else
            {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat
    {
        get
        {
            return layer.shadowRadius
        }
        set
        {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float
    {
        get
        {
            return layer.shadowOpacity
        }
        set
        {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize
    {
        get
        {
            return layer.shadowOffset
        }
        set
        {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor?
    {
        get
        {
            if let color = layer.shadowColor
            {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set
        {
            if let color = newValue
            {
                layer.shadowColor = color.cgColor
            } else
            {
                layer.shadowColor = nil
            }
        }
    }
}

extension UIView {
    
    func makeOutwardNeomorphic(reversed: Bool = false, offsetValue: CGFloat = 8.0, cornerRadius: CGFloat = 35.0, shadowRadius: CGFloat = 15.0, alphaLight: CGFloat = 0.2, alphaDark: CGFloat = 0.8) {
        
        let offset = reversed ? offsetValue : -offsetValue
        
        var lightLayer: CALayer {
            let layer = CALayer()
            layer.frame = bounds
            layer.shadowOffset = CGSize(width: offset, height: offset)
            layer.shadowRadius = shadowRadius
            layer.shadowOpacity = 1.0
            layer.shadowColor = UIColor.white.withAlphaComponent(alphaLight).cgColor
            layer.backgroundColor = backgroundColor?.cgColor
            layer.cornerRadius = bounds.height / 2.0
            return layer
        }
        
        var darkLayer: CALayer {
            let layer = CALayer()
            layer.frame = bounds
            layer.shadowOffset = CGSize(width: -offset, height: -offset)
            layer.shadowRadius = shadowRadius
            layer.shadowOpacity = 1.0
            layer.shadowColor = UIColor.black.withAlphaComponent(alphaDark).cgColor
            layer.backgroundColor = backgroundColor?.cgColor
            layer.cornerRadius = bounds.height / 2.0
            return layer
        }
        
        layer.insertSublayer(lightLayer, at: 0)
        layer.insertSublayer(darkLayer, at: 0)
        
    }
    
    func makeInwardNeomorphic() {
        
        var lightLayer: CALayer {
            let layer = CALayer()
            layer.frame = bounds
            
            let shadowPath = UIBezierPath(roundedRect: bounds.insetBy(dx: -3, dy: -3), cornerRadius: 35.0)
            let cutout = UIBezierPath(roundedRect: bounds, cornerRadius: 35.0).reversing()
            
            shadowPath.append(cutout)
            layer.shadowPath = shadowPath.cgPath
            
            layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
            layer.shadowRadius = 3
            layer.shadowOpacity = 1.0
            layer.shadowColor = UIColor.white.withAlphaComponent(0.8).cgColor
            layer.backgroundColor = backgroundColor?.cgColor
            
            return layer
        }
        
        var darkLayer: CALayer {
            let layer = CALayer()
            layer.frame = bounds
            
            let shadowPath = UIBezierPath(roundedRect: bounds.insetBy(dx: 3, dy: 3), cornerRadius: 35.0)
            let cutout = UIBezierPath(roundedRect: bounds, cornerRadius: 35.0).reversing()
            
            shadowPath.append(cutout)
            layer.shadowPath = shadowPath.cgPath
            
            layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
            layer.shadowRadius = 3
            layer.shadowOpacity = 1.0
            layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
            layer.backgroundColor = backgroundColor?.cgColor
            
            return layer
        }
        
        layer.insertSublayer(lightLayer, at: 0)
        layer.insertSublayer(darkLayer, at: 0)
        
    }
    
}
