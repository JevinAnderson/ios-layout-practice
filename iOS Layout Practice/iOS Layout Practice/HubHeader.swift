//
//  HubHeader.swift
//  iOS Layout Practice
//
//  Created by Anderson, Jevin on 11/30/18.
//  Copyright © 2018 Anderson, Jevin. All rights reserved.
//

import UIKit

class HubHeader: UIView {
  @IBOutlet weak var loadingView: UIView!
  @IBOutlet var contentView: UIView!
  @IBOutlet weak var balanceLabel: UILabel!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
    didSet {
      activityIndicator.startAnimating()
    }
  }
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  func setup() {
    Bundle.main.loadNibNamed("HubHeader", owner: self, options: nil)
    addSubview(contentView)
    contentView.frame = self.bounds
    contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    updateBalance()
  }
  
  func updateBalance() {
    if let hub = HubModel.shared.hub {
      loadingView.isHidden = true
      activityIndicator.stopAnimating()
      balanceLabel.text = "$\(hub.balance)"
    }
  }
}
