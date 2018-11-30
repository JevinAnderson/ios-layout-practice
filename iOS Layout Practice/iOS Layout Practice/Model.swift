//
//  Model.swift
//  iOS Layout Practice
//
//  Created by Anderson, Jevin on 11/29/18.
//  Copyright © 2018 Anderson, Jevin. All rights reserved.
//

import UIKit

protocol HubModelDelegate: class {
  func onModelUpdate(_ model: HubModel)
}

enum TransactionType {
  case normal, special
}

protocol Transaction: class {
  var type: TransactionType {get}
}

class HubModel {
  weak var delegate: HubModelDelegate?
  static let shared = HubModel()
  var loading = true
  
  var creditLine: Double?
  var balance: Double?
  var availableCredit: Double?
  var paymentDate: String?
  var minimumPaymentDue: Double?
  var lastStatementBalance: Double?
  
  var statements: [Any]?
  var transactions: [Transaction]?
  
  func fetch() {
    delegate?.onModelUpdate(self)
  }
  
}
