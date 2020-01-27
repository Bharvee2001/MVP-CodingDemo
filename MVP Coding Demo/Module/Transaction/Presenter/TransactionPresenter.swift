//
//  TransactionPresenter.swift
//  MVP Coding Demo
//
//  Created by Sumit Parmar on 04/01/20.
//  Copyright © 2020 Sumit Parmar. All rights reserved.
//

import Foundation

class TransactionPresenter  {

    let transactionDataManager : TransactionDataManager
    let transactionService : TransactionService
    weak var transactionDelegate: TranssactionDelegate?
    init(transactionDelegate: TranssactionDelegate) {
        self.transactionDelegate = transactionDelegate
        self.transactionService = TransactionService()
        self.transactionDataManager = TransactionDataManager()
    }

    func fetchTransactionHistoryList(){
          let paramDict =  self.transactionDataManager.prepareDataForTransacationHistoryRequest()

          if paramDict.count > 0 {
              transactionService.getTransactionHistoryList(paramDict: paramDict, completionHandler: {
                  (transactionHistoryResponse) in

                  if transactionHistoryResponse != nil{
                    self.transactionDelegate?.transactionHistoryDidSucceed(transactionData: transactionHistoryResponse!)
                    print("Data Recieved")
                  }
              }) {
                  (errorObject) in
                self.transactionDelegate?.transactionHistoryDidFailed(error: errorObject as! ServerError)
              }
          }

      }
}
