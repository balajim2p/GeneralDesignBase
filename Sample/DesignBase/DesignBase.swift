//
//  DesignBase.swift
//  DesignBase
//
//  Created by Balaji  on 15/02/22.
//

import Foundation
import UIKit

public class DesignBase {
    
    static public var shared = DesignBase()
    
    public func isInternetStatus()->Bool{
        return isInternetAvailable()
    }
    
    /*Present VC View*/
    public func present(from parentController: UIViewController){
        
    }
    
    public func openWebViewVC(url:String,title:String,from parentController: UIViewController){
        let viewController = UIStoryboard(name: "DesignBase", bundle: DesignBundle.shared.currentBundle).instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
       if url.isEmpty{
           //self.alertWithNoAction(title:"No data to load")
       }
       else
       {
           viewController.vcTitle = title
           viewController.getURl = url
           parentController.present(viewController, animated: true, completion: nil)
       }
       
   }
}

