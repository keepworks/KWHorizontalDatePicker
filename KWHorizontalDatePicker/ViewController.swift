//
//  ViewController.swift
//  KWHorizontalDatePicker
//
//  Created by Pavan Kotesh on 14/04/20.
//  Copyright © 2020 KeepWorks. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  // MARK: - IBOutlets
  @IBOutlet weak var datePicker: HorizontalPicker!
  @IBOutlet weak var dateLabel: UILabel!

  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()

    datePicker.setup()
    datePicker.didSelectDate = { (date) in
      self.dateLabel.text = date.toString(format: "dd MMM YYYY")
    }
  }
}

