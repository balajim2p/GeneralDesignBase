//
//  ViewController.swift
//  Sample
//
//  Created by Balaji  on 15/02/22.
// /* EX: */

import UIKit
import DesignBase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* EX: InternetStatus*/
        print(DesignBase.shared.isInternetStatus())
        
        /* EX: Corner radius , Color , OneEdgeCorner*/
        let myView = UIView()
        myView.frame = CGRect(x: 10, y: 100, width: 100, height: 100)
        myView.setCornerRadius(radius: 20)
        myView.roundCorners(corners: .bottomRight, radius: 34)
        myView.backgroundColor = UIColor.setColour(colour: Colour.darkRed.rawValue)
        self.view.addSubview(myView)
        
        /* EX: Trim WhiteSpace*/
        print(" Trimspace ".trim)
        
        /* EX: View Color*/
        
        
    }
}

