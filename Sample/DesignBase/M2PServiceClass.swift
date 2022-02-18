//
//  M2PServiceClass.swift
//  DesignBase
//
//  Created by Balaji  on 18/02/22.
//

import UIKit
import Foundation
import Alamofire
import ObjectMapper


public class M2PWebServiceClass: NSObject {
    public static let shared = M2PWebServiceClass()
    public func callAPI<T: Mappable>(type: T.Type,
                                     with api:String,
                                     method: HTTPMethod,
                                     parameter: Parameters?,
                                     headers :HTTPHeaders?,
                                     URL :String? = "",
                                     completion: @escaping  (_ result: T?,_ error:String?, _ code: Int, _ headLessResponse : Any?) -> Void)  {
        guard isInternetAvailable() else {
            print("No Internet")
            return
        }
        showLoader()
        
        var param: Parameters = [:]
        var urlString = "\(URL ?? "")"+"\(api)"
        
        var loginheaders:HTTPHeaders = [:]
        loginheaders["Content-Type"] = "application/json"
        
        var parameterEncode : ParameterEncoding = JSONEncoding.default
        
        if method == .get {
            parameterEncode = URLEncoding.default
            if parameter != nil {
                var postString = ""
                for (key,value) in parameter ?? [:] {
                    postString += key + "=" + "\(value)" + "&"
                }
                if postString.hasSuffix("&") {
                    postString.removeLast()
                }
                urlString = urlString + "?" + postString
            }
        }else{
            param = parameter ?? [:]
        }
        
        print("urlString ... \(urlString)")
        print("parameter ... \(parameter ?? [:])")
        print("Headers ... \(loginheaders)")
        
        AF.request(urlString, method: method, parameters: param,encoding: parameterEncode, headers: loginheaders)
            .responseJSON { (response) in
                hideLoader()
                let code = response.response?.statusCode
                switch response.result {
                case .success(let json) :
                    let responseValue = Mapper<T>().map(JSONObject: json)
                    completion(responseValue,nil,code ?? 0, nil)
                case .failure(let error):
                    print(error)
                    let error = error.localizedDescription
                    if error == "Unauthenticated." {
                        return
                    }
                    completion(nil,error,code ?? 0, nil)
                }
            }
    }
}
