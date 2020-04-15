//
//  UIViewExtension.swift
//  KWHorizontalDatePicker
//
//  Created by Pavan Kotesh on 14/04/20.
//  Copyright © 2020 KeepWorks. All rights reserved.
//

import UIKit

extension UIView {
  class func getNibName() -> String {
    return NSStringFromClass(self).components(separatedBy: ".").last!
  }

  class func getCellIdentifier() -> String {
    return getNibName().lowercaseFirst
  }
  
  @discardableResult func loadViewFromNib() -> UIView {
    let nibName = NSStringFromClass(type(of: self)).components(separatedBy: ".").last!
    let view = (Bundle.main.loadNibNamed(nibName, owner: self, options: nil)?.first as? UIView)!
    view.translatesAutoresizingMaskIntoConstraints = false
    addSubview(view)

    let views = ["view": view]
    addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[view]-0-|", options: [], metrics: nil, views: views))
    addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[view]-0-|", options: [], metrics: nil, views: views))
    setNeedsUpdateConstraints()

    return view
  }
}
