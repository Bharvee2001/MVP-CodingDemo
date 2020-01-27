//
//  TransacationViewController.swift
//  MVP Coding Demo
//
//  Created by Sumit Parmar on 04/01/20.
//  Copyright © 2020 Sumit Parmar. All rights reserved.
//

import UIKit

class TransacationViewController: UIViewController {


    @IBOutlet weak var transactionTabelView: UITableView!
    var transactionPresenter : TransactionPresenter?
    var transactionHistorYArray = Array<TransactionHistory>()

    override func viewDidLoad() {
        super.viewDidLoad()
        // call api
        // get modal data from any method or any where esle
        // tableview method imaplemetation
        // send modal object to cell class
        initComponets()
    }
    func initComponets() {
        initPresnter()
        fetchTransactionHistory()
    }
    func initPresnter(){
        transactionPresenter = TransactionPresenter(transactionDelegate: self)
    }
    func fetchTransactionHistory() {
        transactionPresenter?.fetchTransactionHistoryList()
    }
}

extension TransacationViewController : TranssactionDelegate,UITableViewDataSource,UITableViewDelegate {

    func transactionHistoryDidSucceed(transactionData: TransactionData) {
        print(transactionData.transactionHistoryList?.count)
        if transactionData.transactionHistoryList?.count ?? 0  > 0 {
            self.transactionHistorYArray =  transactionData.transactionHistoryList!
            self.transactionTabelView.reloadData()
        }
    }

    func transactionHistoryDidFailed(error: ServerError) {
        print(error)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactionHistorYArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "transactionCellID", for: indexPath)as! TransactionTableViewCell
        let transactionHistory = transactionHistorYArray[indexPath.row]
        cell.prepareData(modal : transactionHistory)
        return cell
    }
}
