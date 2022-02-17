//
//  DesignBundle.swift
//  DesignBase
//
//  Created by Balaji  on 16/02/22.
//

import UIKit
import Foundation

/*To Get bundle Name*/
class DesignBundle {
    static var shared = DesignBundle()
    private init() { }
    
    /*Access from Resource Bundle*/
    var currentBundle: Bundle  {
        let frameworkBundle = Bundle(identifier: "com.designbase.sdk")!
        return frameworkBundle
    }
    
    /*To get DeviceId and BundleId*/
    var deviceId: String? { return UIDevice.current.identifierForVendor?.uuidString.filter { $0 != "-" } }
    var bundleId: String? { return Bundle.main.object(forInfoDictionaryKey: "CFBundleIdentifier") as? String }
}
