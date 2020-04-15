//
//  DateCell.swift
//  KWHorizontalDatePicker
//
//  Created by Pavan Kotesh on 14/04/20.
//  Copyright © 2020 KeepWorks. All rights reserved.
//

import UIKit

class DateCell: UICollectionViewCell {
  
  // MARK: - IBOutlets
  @IBOutlet weak var datelabel: UILabel!
  
  // MARK: - Variables
  var date: Date = Date() {
    didSet {
      datelabel.text = date.toString()
    }
  }
  
  // MARK: - LifeCycle
  override var isSelected: Bool {
    didSet{
      datelabel.textColor = isSelected ? .blue : .black
    }
  }
}
