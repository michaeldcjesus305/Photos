//
//  UIViewExtension.swift
//  Photos
//
//  Created by michael on 09/08/17.
//  Copyright © 2017 Michael. All rights reserved.
//

import UIKit


extension UIView {
    
    func addGradientBackground(){
        
        let gradientLayer = CAGradientLayer()
        
        let startColor = Colors.BLUE_BACKGROUND_GRADIENT_START_COLOR
        let endColor = Colors.BLUE_BACKGROUND_GRADIENT_END_COLOR
        
        gradientLayer.frame = CGRect(origin: CGPoint.zero, size: self.frame.size)
        gradientLayer.colors = [startColor,endColor].map{$0.cgColor}
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
}
