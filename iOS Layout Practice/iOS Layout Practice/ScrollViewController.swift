//
//  ScrollViewController.swift
//  iOS Layout Practice
//
//  Created by Anderson, Jevin on 11/29/18.
//  Copyright © 2018 Anderson, Jevin. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController, menuDelegate, HubModelDelegate {
  @IBOutlet weak var scrollSubViewHeightConstraint: NSLayoutConstraint!
  @IBOutlet weak var menuView: menu!
  @IBOutlet weak var headerView: HubHeader!
  
  
  
  func onModelUpdate(_ model: HubModel) {
    print("Model updated!")
    headerView.updateBalance()
  }
  
  func onMenuBack(_ sender: UIButton) {
    self.dismiss(animated: true, completion: nil)
  }
  
  func menuLabel() -> String {
    return "ScrollViewController"
  }
  
  override func viewDidLoad() {
    menuView.delegate = self
//    HubModel.shared.delegate = self
    HubModel.shared.addObserver(self)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    HubModel.shared.removeObserver(self)
  }
}
