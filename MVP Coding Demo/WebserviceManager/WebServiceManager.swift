//
//  WebServiceManager.swift
//  WebserviceManagerDemo
//
//  Created by Sumit Parmar on 14/12/19.
//  Copyright © 2019 Sumit Parmar. All rights reserved.
//

import Foundation
import Alamofire

enum ServerError : Error {
    case errorDetails(Int,String)
}

class WebServiceManager: NSObject {

    class var sharedInstance : WebServiceManager {
        struct Static {
            static let instance : WebServiceManager = WebServiceManager()
        }
        return Static.instance
    }

    let manager: Alamofire.SessionManager = {
        let configuration = URLSessionConfiguration.default
        let sessionManager = Alamofire.SessionManager(configuration: configuration)
        return sessionManager
    }()

    func getWebserviceCall(requestURL: String, headers:HTTPHeaders , successHandler:@escaping (Dictionary<String,Any>) -> Void , failureHandler:@escaping ((_ error:ServerError) -> Void)) {

        print("URL: \(requestURL)")
        print(requestURL)

        manager.request(requestURL, headers: headers).validate()
            .responseJSON { response in

                if response.error != nil {
                    print(response.error as Any)
                    failureHandler(ServerError.errorDetails(0, "try again"))
                }else{
                    if response.response?.statusCode == 200 {

                        if let json =  response.result.value {

                            guard let jsonDictionary : Dictionary<String,Any> = json as? Dictionary<String,Any> else {
                                return
                            }

                            print(jsonDictionary)
                            guard let status = jsonDictionary["status"] as? Int else {
                                print("Status Key Not Found")
                                return
                            }

                            if status == 1 {
                                successHandler(jsonDictionary)
                            }else{
                                print("Error Is : \(jsonDictionary)")
                            }

                        }
                    }
                }
        }
    }

    func postWebserviceCall(requestURL:String, params : [String : Any],headers:HTTPHeaders,successHandler:@escaping (_ responseData:Dictionary<String,Any>) -> Void, failureHandler:@escaping ((_ error:ServerError) -> Void)) {
        print("URL: \(requestURL)")
        print("BodyData: \(params)")
        manager.request(requestURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).validate()
            .responseJSON { response in

                if response.error == nil {
                    if response.response?.statusCode == 200 {
                        if let json =  response.result.value {
                            guard let jsonDictionary : Dictionary<String,Any> = json as? Dictionary<String,Any> else {
                                return
                            }
                            print(jsonDictionary)
                            guard let status = jsonDictionary["status"] as? Int else {
                                print("Status Key Not Found")
                                return
                            }
                            if status == 1 {
                                successHandler(jsonDictionary)
                            }else{
                                print("Error Is : \(jsonDictionary)")
                            }
                        }
                    }
                }else{
                    failureHandler(ServerError.errorDetails(0, "try again"))
                }
        }
    }
}
