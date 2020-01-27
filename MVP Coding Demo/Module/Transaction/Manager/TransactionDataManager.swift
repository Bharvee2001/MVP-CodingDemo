//
//  DataManager.swift
//  MVP Coding Demo
//
//  Created by Sumit Parmar on 04/01/20.
//  Copyright © 2020 Sumit Parmar. All rights reserved.
//

import Foundation

class TransactionDataManager {

     var responseDictionary : Dictionary<String,Any>?

    init(){
        self.responseDictionary = nil
    }
    init(responseDictionary : Dictionary<String,Any>) {
        self.responseDictionary = responseDictionary
    }

    func prepareDataForTransacationHistoryRequest() -> Dictionary<String,Any> {
        var params:Dictionary = Dictionary<String,Any>()
        params["userId"] = "qM14CcwZKQ"
        params["skip"] = 0
        params["limit"] = 20
        params["appVersion"] = "6.15.0.1"
        return params
    }
    func getTransactionHistoryResponse() -> TransactionData?{
        let transacationData = TransactionData()
        var arrTransactionHistory = Array<TransactionHistory>()
        var transactionHistory : TransactionHistory?

        if self.responseDictionary != nil && self.responseDictionary?.count ?? 0 > 0 {
            guard  let transactionHistoryArray = self.responseDictionary?["transactionList"] as? Array<Dictionary<String,Any>> else {return nil}
            print(transactionHistoryArray)

            for transactionDataDic in transactionHistoryArray {
                transactionHistory = TransactionHistory()

                if transactionDataDic.index(forKey: "date") != nil {
                    transactionHistory?.date = transactionDataDic["date"] as? String
                }
                if transactionDataDic.index(forKey: "subType") != nil {
                    transactionHistory?.subType = transactionDataDic["subType"] as? String
                }

                if transactionDataDic.index(forKey: "type") != nil {
                    transactionHistory?.type = transactionDataDic["type"] as? String
                }

                if transactionDataDic.index(forKey: "amount") != nil {
                    transactionHistory?.amount = transactionDataDic["amount"] as? Double
                }

                if transactionDataDic.index(forKey: "transactionData") != nil {
                    transactionHistory?.transactionData = transactionDataDic["transactionData"] as? Dictionary<String,Any>
                }

                if transactionDataDic.index(forKey: "earnBalance") != nil {
                    transactionHistory?.earnBalance = transactionDataDic["earnBalance"] as? Double
                }

                if transactionDataDic.index(forKey: "referralBalance") != nil {
                    transactionHistory?.referralBalance = transactionDataDic["referralBalance"] as? Double
                }

                arrTransactionHistory.append(transactionHistory!)

                transacationData.transactionHistoryList = arrTransactionHistory

            }
        }
        return transacationData
    }
}
