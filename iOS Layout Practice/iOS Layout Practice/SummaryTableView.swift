//
//  SummaryTableView.swift
//  iOS Layout Practice
//
//  Created by Anderson, Jevin on 12/3/18.
//  Copyright © 2018 Anderson, Jevin. All rights reserved.
//

import UIKit

protocol SummaryTableViewDelegate: class {
  func onSummaryTableViewButtonTap(_ view: SummaryTableView)
}

class SummaryTableView: UIView, UITableViewDataSource, HubModelDelegate {
  @IBOutlet weak var tableViewOutlet: UITableView! {
    didSet {
      tableViewOutlet.dataSource = self
      HubModel.shared.addObserver(self)
    }
  }
  
  deinit {
    HubModel.shared.removeObserver(self)
  }
  
  func onModelUpdate(_ model: HubModel) {
    self.tableViewOutlet.reloadData()
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let hub = HubModel.shared.hub else {
      return 0
    }
    
    var count = 2
    
    if hub.minimumPaymentDue > 0 {
      count += 1
    }
    
    if hub.lastStatementBalance > 0 {
      count += 1
    }
    
    return count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCell(withIdentifier: "SummaryTableViewCell")
    
    if cell == nil {
      cell = UITableViewCell(style: .value1, reuseIdentifier: "SummaryTableViewCell")
    }
    
    
    
    switch indexPath.row {
    case 0:
      cell!.textLabel?.text = "Available Credit"
      cell!.detailTextLabel?.text = "$\(HubModel.shared.hub!.availableCredit)"
    case 1:
      cell!.textLabel?.text = "Payment Due Date"
      cell!.detailTextLabel?.text = HubModel.shared.hub!.paymentDate
    default:
      if indexPath.row == 2 && HubModel.shared.hub!.minimumPaymentDue > 0 {
        cell!.textLabel?.text = "Minimum Payment Due"
        cell?.detailTextLabel?.text = "$\(HubModel.shared.hub!.minimumPaymentDue)"
      }else{
        cell!.textLabel?.text = "Last statement balance"
        cell?.detailTextLabel?.text = "$\(HubModel.shared.hub!.lastStatementBalance)"
      }
    }
    
    return cell!
  }
  
  @IBOutlet var contentView: UIView!
  @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
  @IBOutlet weak var toggleButton: UIButton!
  @IBOutlet weak var showDetailsLabel: UILabel!
  
  
  weak var delegate: SummaryTableViewDelegate?
  var expanded = false {
    didSet {
      transformButton()
    }
  }
  
  var transforming: Bool {
    return animating
  }
  
  private var animating = false
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  func setup() {
    Bundle.main.loadNibNamed("SummaryTableView", owner: self, options: nil)
    addSubview(contentView)
  }
  
  private func transformButton() {
    animating = true
    
    UIView.animate(withDuration: 0.6, animations: {
      self.toggleButton.transform = self.toggleButton.transform.rotated(by: CGFloat(Double.pi))
    }) { _ in
      self.animating = false
      self.showDetailsLabel.text = self.expanded ? "Hide Details": "Show Details"
    }
  }
  
  @IBAction func onButtonTap(_ sender: UIButton) {
    self.expanded = !self.expanded
    self.delegate?.onSummaryTableViewButtonTap(self)
  }
}
