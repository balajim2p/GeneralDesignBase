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
    
}

