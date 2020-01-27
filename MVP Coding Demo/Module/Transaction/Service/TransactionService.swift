//
//  TransactionService.swift
//  MVP Coding Demo
//
//  Created by Sumit Parmar on 04/01/20.
//  Copyright © 2020 Sumit Parmar. All rights reserved.
//

import Foundation
import Alamofire

class TransactionService {
    func getTransactionHistoryList(paramDict:Dictionary<String,Any>,completionHandler:@escaping (_ responseObjectModal:TransactionData?) -> Void,failureHandler:@escaping ((_ error:Error) -> Void)){

        let accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiJxTTE0Q2N3WktRIiwidXNlcm5hbWUiOiI2MzUxMTg1Mjc5IiwiaWF0IjoxNTY4MTQ3MjA2LCJleHAiOjc3NzYwMDAwMTU2ODE0NzIwMH0.T-_NWff-If7MjzwnbDOQgB35wgXDOGImnStwQ7ZSuWw"

        let headers = setupHeadersForUserUpdate(accessToken: accessToken)

        requestToGetTransactionHistoryList(params: paramDict, headers: headers, successHandler: { (transactionHistoryRespondsModal) in
            completionHandler(transactionHistoryRespondsModal)
        }) { (errorObject) in
            failureHandler(errorObject)
        }

    }
    //MARK: SET UP HEADER
    func setupHeadersForUserUpdate(accessToken:String) -> HTTPHeaders {
        let headers: HTTPHeaders = [
            "X-SRIDE-AUTH" : accessToken
        ]
        return headers
    }
    func requestToGetTransactionHistoryList(params:[String:Any], headers:HTTPHeaders, successHandler:@escaping (_ responseData: TransactionData?) -> Void, failureHandler:@escaping ((_ error:ServerError) -> Void)){

        WebServiceManager.sharedInstance.postWebserviceCall(requestURL: "https://api-test.sridecarpool.com/api/transaction/list", params: params, headers: headers, successHandler: {
            (responseDict) in

                    if responseDict.count > 0 {

                        let transactionDataManager = TransactionDataManager(responseDictionary: responseDict)

                        let transactionData = transactionDataManager.getTransactionHistoryResponse()
                        successHandler(transactionData!)

                    }else{
                        failureHandler(ServerError.errorDetails(0, "Transaction History details not available."))
                    }


        }) { (errorObject) in
            failureHandler(errorObject)
        }
    }

}
