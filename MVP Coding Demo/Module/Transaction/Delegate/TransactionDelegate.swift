//
//  TransactionDelegate.swift
//  MVP Coding Demo
//
//  Created by Sumit Parmar on 04/01/20.
//  Copyright © 2020 Sumit Parmar. All rights reserved.
//

import Foundation

protocol TranssactionDelegate : class {
   
    func transactionHistoryDidSucceed(transactionData :TransactionData)
    func transactionHistoryDidFailed(error: ServerError)
}
