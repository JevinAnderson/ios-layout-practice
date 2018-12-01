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

private let kSecond = 1.0
private let kMinute = 60 * kSecond
private let kHour = 60 * kMinute

let kHUB_STAGNATION = 30 * kSecond
let kHUB_URL = "http://127.0.0.1:2001/hub"
let kPROMOTIONS_STAGNATION = 30 * kMinute
let kPROMOTIONS_URL = "http://127.0.0.1:2001/promotions"
let kTRANSACTIONS_STAGNATION = kHour
let kTRANSACTIONS_URL = "http://127.0.0.1:2001/transactions/all"

struct HubResponse: Codable {
  var timestamp: Int
  var creditLine: Int
  var balance: String
  var availableCredit: Double
  var paymentDate: String
  var minimumPaymentDue: String
  var lastStatementBalance: String
}

struct DateResponse: Codable {
  var day: Int
  var month: String
  var year: Int
  var mdy: String
}

struct Promotion: Codable {
  var issuer: String
  var balance: String
  var img: String
  var title: String
  var description: String
  var dateObj: DateResponse
}

struct PromotionResponse: Codable {
  var timestamp: Int
  var promotions: [Promotion]
}

struct Transaction: Codable {
  var balance: String
  var img: String
  var title: String
  var description: String
  var date: String
  var dateObj: DateResponse
}

struct TransactionResponse: Codable {
  var timestamp: Int
  var total: Int
  var transactions: [Transaction]
}

class HubModel {
  weak var delegate: HubModelDelegate? {
    didSet {
      fetch()
    }
  }
  
  static let shared = HubModel()
  
  var hub: HubResponse?
  var transactions: [Transaction]?
  var promotions: [Promotion]?
  
  func fetch() {
    fetchHub()
    fetchTransactions()
    fetchPromotions()
  }
  
  var now: Double {
    get {
      return NSDate().timeIntervalSince1970
    }
  }
  
  var lastHubFetch: Double?
  
  private func fetchHub() {
    if(lastHubFetch != nil && now - lastHubFetch! <= Double(kHUB_STAGNATION)) {
      return
    }
    
    lastHubFetch = now
    
    guard let url = URL(string: kHUB_URL) else { return }
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      guard error == nil else {return}
      guard let data = data else {return}
      let decoder = JSONDecoder()
      
      do {
        self.hub = try decoder.decode(HubResponse.self, from: data)
        self.delegate?.onModelUpdate(self)
      } catch {
        return
      }
      }.resume()
  }
  
  var lastTransactionFetch: Double?
  private func fetchTransactions() {
    if(lastTransactionFetch != nil && now - lastTransactionFetch! <= kTRANSACTIONS_STAGNATION) {
      return
    }
    
    lastTransactionFetch = now
    
    guard let url = URL(string: kTRANSACTIONS_URL) else { return }
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      guard error == nil else {return}
      guard let data = data else {return}
      let decoder = JSONDecoder()
      
      do {
        let transactionResponse = try decoder.decode(TransactionResponse.self, from: data)
        self.transactions = transactionResponse.transactions
        self.delegate?.onModelUpdate(self)
      } catch let err {
        print("\(err)")
        return
      }
      }.resume()
  }
  
  var lastPromotionFetch: Double?
  private func fetchPromotions() {
    if(lastPromotionFetch != nil && now - lastPromotionFetch! <= kPROMOTIONS_STAGNATION) {
      return
    }
    
    lastPromotionFetch = now
    
    guard let url = URL(string: kPROMOTIONS_URL) else { return }
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      guard error == nil else {return}
      guard let data = data else {return}
      let decoder = JSONDecoder()
      
      do {
        let promotionResponse = try decoder.decode(PromotionResponse.self, from: data)
        self.promotions = promotionResponse.promotions
        self.delegate?.onModelUpdate(self)
      } catch {
        return
      }
      }.resume()
  }
}
