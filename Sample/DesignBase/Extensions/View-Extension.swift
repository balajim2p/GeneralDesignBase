//
//  UIView.swift
//  DesignBase
//
//  Created by Balaji  on 15/02/22.
//

import Foundation
import UIKit

public extension UIViewController {
    
    /*Dismiss or Pop back*/
    func dismissVC(){
        if (self.presentingViewController != nil){
            self.dismiss(animated: true, completion: nil)
        }else{
            _ = navigationController?.popViewController(animated: true)
        }
    }
    
    func delay(interval: TimeInterval, closure: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
            closure()
        }
    }
    
    func alertWithNoAction(title : String = "Coming Soon ...", delay : Int = 2){
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        self.present(alertController, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(delay)){
                alertController.dismiss(animated: true, completion: nil)
            }
        }
    }
}

/** Extension to show Generic Message Alert Controller throughout the App **/
public extension UIViewController{
    enum AlertTitle: String{
        case Success = "Success"
        case Error = "Error"
        case Alert = "Alert"
    }
    
    func showMessageAlert(title: String = AlertTitle.Alert.rawValue, message: String?, showRetry: Bool = true, retryTitle: String? = nil, showCancel: Bool = true, cancelTitle: String? = nil, onRetry: (() -> ())?, onCancel: (() -> ())?){
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            if showRetry{
                alertController.addAction(UIAlertAction(title: retryTitle ?? "Retry", style: .default, handler: { (retry) in
                    guard let onRetry = onRetry else{
                        return
                    }
                    onRetry()
                }))
            }
            if showCancel{
                alertController.addAction(UIAlertAction(title: cancelTitle ?? "Cancel", style: .cancel, handler: { (cancel) in
                    guard let onCancel = onCancel else{
                        return
                    }
                    onCancel()
                }))
            }
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

/* Open web view Viewcontroller*/
public extension UIViewController {
    func openWebViewVC(url:String,title:String){
        let viewController = UIStoryboard(name: "DesignBase", bundle: DesignBundle.shared.currentBundle).instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        if url.isEmpty{
            self.alertWithNoAction(title:"No data to load")
        }
        else
        {
            viewController.vcTitle = title
            viewController.getURl = url
            self.present(viewController, animated: true, completion: nil)
        }
        
    }
}
