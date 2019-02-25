//
//  PaymentDetailsModel.swift
//  Automatic Height Test
//
//  Created by Anderson, Jevin on 2/24/19.
//  Copyright © 2019 Anderson, Jevin. All rights reserved.
//

import Foundation

struct PaymentDetailsModel {
  let label: String
  let value: String
  
  init(_ label: String, _ value: String) {
    self.label = label
    self.value = value
  }
  
  func configureCell(_ cell: PaymentDetailsCell) {
    cell.contentLabel.text = label
    cell.amountLabel.text = value
  }
}
