//
//  Constant.swift
//  DesignBase
//
//  Created by Balaji  on 18/02/22.
//

import Foundation
@_implementationOnly import ZVProgressHUD

/*Show API Loader*/
func showLoader(text : String = "Loading"){
    ZVProgressHUD.show(with: text , delay: 0)
}

/*Hide API Loader*/
func hideLoader(){
    ZVProgressHUD.dismiss()
}
