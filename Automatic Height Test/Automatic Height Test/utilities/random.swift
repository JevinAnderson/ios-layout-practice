//
//  random.swift
//  Automatic Height Test
//
//  Created by Anderson, Jevin on 2/24/19.
//  Copyright © 2019 Anderson, Jevin. All rights reserved.
//

import Foundation


class Random {
  private static let alphabet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
  class func string(_ length: Int = Int.random(in: 1 ..< 200)) -> String {
    return String((0...length-1).map{ _ in alphabet.randomElement()! })
  }
  
  private static let currencyFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    
    return formatter
  }()
  
  class func money() -> String {
    var value = Double.random(in: 0.0...1000000000.0)
    
    if let formattedMoney = currencyFormatter.string(from: value as NSNumber) {
      return formattedMoney
    } else {
      value = round(value * 100.0) / 100.0
      return "$\(value)"
    }
  }
  
  class func paymentDetailsModel() -> PaymentDetailsModel {
    return PaymentDetailsModel(string(), money())
  }
  
  class func promotionModel() -> PromotionCellModel {
    return PromotionCellModel(details: string())
  }
}
