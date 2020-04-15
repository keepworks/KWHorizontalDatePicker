//
//  UICollectionViewExtension.swift
//  KWHorizontalDatePicker
//
//  Created by Pavan Kotesh on 14/04/20.
//  Copyright © 2020 KeepWorks. All rights reserved.
//

import UIKit

extension UICollectionView {
  func registerNib(_ viewClass: UIView.Type) {
    let nib = UINib(nibName: viewClass.getNibName(), bundle: nil)
    register(nib, forCellWithReuseIdentifier: viewClass.getCellIdentifier())
  }

  func dequeueReusableCell<T: UICollectionViewCell>(_ collectionViewCellClass: T.Type, forIndexPath indexPath: IndexPath) -> T {
    return self.dequeueReusableCell(withReuseIdentifier: collectionViewCellClass.getCellIdentifier(), for: indexPath) as! T
  }
  
  func validate(_ indexPath: IndexPath) -> Bool {
    if indexPath.section >= numberOfSections {
      return false
    }

    if indexPath.row >= numberOfItems(inSection: indexPath.section) {
      return false
    }

    return true
  }
}
