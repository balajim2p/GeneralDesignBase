//
//  UIView.swift
//  DesignBase
//
//  Created by Balaji  on 15/02/22.
//

import Foundation
import UIKit

/*UIView extension class*/
public extension UIView {
    
    /*Set Corner Radius for view*/
    func setCornerRadius(radius : CGFloat = 10) {
        self.layer.cornerRadius = radius
    }
    
    /*Set Border With Radius for view*/
    func setRoundedBorder(radius : CGFloat = 10, color : CGColor, width : CGFloat = 1) {
        layer.cornerRadius = radius
        layer.borderWidth = width
        layer.borderColor = color
    }
    
    /*Set Corner for selected Edge*/
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    /*Set Circle Radius*/
    func circleRadius(){
        self.layer.cornerRadius = self.frame.size.height/2
    }
    
    /*Dismiss the custom view*/
    func dismissView(onCompletion completion : (()->Void)?){
        self.removeFromSuperview()
        completion?()
    }
}
