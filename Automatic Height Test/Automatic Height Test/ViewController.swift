//
//  ViewController.swift
//  Automatic Height Test
//
//  Created by Anderson, Jevin on 2/24/19.
//  Copyright © 2019 Anderson, Jevin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  let paymentDetails: [PaymentDetailsModel] = (0...20).map { _ in Random.paymentDetailsModel() }
  var expandedDetails = false {
    didSet {
      if expandedDetails {
        table.insertRows(at: detailsExpansionIndices, with: .fade)
      } else {
        table.deleteRows(at: detailsExpansionIndices, with: .bottom)
      }
    }
  }
  
  var detailsExpandable: Bool {
    return paymentDetails.count > kMinimizedPaymentDetails
  }
  
  let kDetailsCellIdentifier = "PaymentDetailsCell"
  let kMinimizedPaymentDetails = 2
  var detailsExpansionIndices: [IndexPath] {
    guard detailsExpandable else { return [] }
    
    var row = kMinimizedPaymentDetails
    return paymentDetails[kMinimizedPaymentDetails...].map({ _ -> IndexPath in
      let path = IndexPath(row: row, section: 0)
      row += 1
      return path
    })
  }
  
  var toggleDetailsIndex: IndexPath {
    let section: Int = 0
    let row: Int = expandedDetails ? paymentDetails.count : kMinimizedPaymentDetails
    
    return IndexPath(row: row, section: section)
  }
  
  func samePath(_ x: IndexPath, _ y: IndexPath) -> Bool {
    return x.row == y.row && x.section == y.section
  }
  
  let promotions: [PromotionCellModel] = (0...20).map { _ in
    return Random.promotionModel()
  }
  
  let kPromotionCollapsedLength = 3
  var promotionsExpanded: Bool = false {
    didSet {
      if promotionsExpanded {
        table.insertRows(at: promotionExpandIndices, with: .fade)
      } else {
        table.deleteRows(at: promotionExpandIndices, with: .fade)
      }
    }
  }
  var promotionExpandIndices: [IndexPath] {
    var row = kPromotionCollapsedLength
    return promotions[kPromotionCollapsedLength...].map({ _ -> IndexPath in
      let path = IndexPath(row: row, section: 1)
      row += 1
      return path
    })
  }
  
  var togglePromotionsPath: IndexPath {
    let section = 1
    let row = promotionsExpanded ? promotions.count : kPromotionCollapsedLength
    
    return IndexPath(row: row, section: section)
  }
  
  @IBOutlet weak var table: UITableView! {
    didSet {
      table.delegate = self
      table.dataSource = self
      table.register(UINib(nibName: kDetailsCellIdentifier, bundle: nil), forCellReuseIdentifier: kDetailsCellIdentifier)
      table.register(UINib(nibName: PaymentDetailsToggleCell.identifier, bundle: nil), forCellReuseIdentifier: PaymentDetailsToggleCell.identifier)
      table.register(UINib(nibName: "PromotionHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "PromotionHeader")
      table.register(UINib(nibName: "PromotionCell", bundle: nil), forCellReuseIdentifier: "PromotionCell")
      table.register(UINib(nibName: "PromotionToggleCell", bundle: nil), forCellReuseIdentifier: "PromotionToggleCell")
      table.reloadData()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  
}

extension ViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
      let base = expandedDetails ? paymentDetails.count : kMinimizedPaymentDetails
      
      return base + 1
    }
    
    if section == 1 {
      let base = promotionsExpanded ? promotions.count : kPromotionCollapsedLength
      
      return base + 1
    }
    
    return 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath == toggleDetailsIndex {
      return tableView.dequeueReusableCell(withIdentifier: PaymentDetailsToggleCell.identifier, for: indexPath)
    }
    
    if indexPath == togglePromotionsPath {
      return tableView.dequeueReusableCell(withIdentifier: "PromotionToggleCell", for: indexPath)
    }
    
    if indexPath.section == 0 {
      let cell = tableView.dequeueReusableCell(withIdentifier: kDetailsCellIdentifier, for: indexPath) as! PaymentDetailsCell
      paymentDetails[indexPath.row].configureCell(cell)
      
      return cell
    }
    
    if indexPath.section == 1 {
      let cell = tableView.dequeueReusableCell(withIdentifier: "PromotionCell", for: indexPath) as! PromotionCell
      
      promotions[indexPath.row].configureCell(cell)
      
      return cell
    }
    
    return UITableViewCell()
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    if section == 1 {
      let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "PromotionHeader")
      
      return header
    }
    
    return nil
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    if section == 1 {
      return 50.0
    }
    
    return 0
  }
}

extension ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath == toggleDetailsIndex {
      self.expandedDetails = !expandedDetails
    }
    
    if indexPath == togglePromotionsPath {
      self.promotionsExpanded = !self.promotionsExpanded
    }
  }
}
