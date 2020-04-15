//
//  HorizontalPicker.swift
//  KWHorizontalDatePicker
//
//  Created by Pavan Kotesh on 14/04/20.
//  Copyright © 2020 KeepWorks. All rights reserved.
//

import UIKit

typealias dateSelectionHandler = (Date) -> Void

class HorizontalPicker: UIView {
 
  // MARK: - IBOutlets
  @IBOutlet weak var collectionView: UICollectionView!
  
  // MARK: - Variables
  fileprivate var dates = [Date]()
  fileprivate var activeIndexPath :IndexPath? = nil
  var didSelectDate: dateSelectionHandler? = nil {
    didSet {
      if oldValue == nil {
        selectToday()
      }
    }
  }

  // MARK: - Life Cycle
  override init(frame: CGRect) {
    super.init(frame: frame)

    loadViewFromNib()
    configureCollectionView()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

    loadViewFromNib()
    configureCollectionView()
  }

  // MARK: - Public Methods
  func setup() {
    let today = Date().dateAtStartOfDay()
    let startDate = today.dateBySubtractingDays(30)
    let endDate = today.dateByAddingDays(30)

    dates = startDate.arrayOfdatesTill(endDate)
    collectionView.reloadData()
    selectToday()
    
    setupUI()
  }
  
  // MARK: - Private Methods
  private func configureCollectionView() {
    collectionView.registerNib(DateCell.self)
  }
  
  private func selectToday() {
    let firstIndexPath = IndexPath(row: 1, section: 0) // TODO: Change to today
    if collectionView.validate(firstIndexPath) {
      selectCellAt(firstIndexPath)
    }
  }
  
  private func setupUI() {
    collectionView.backgroundColor = backgroundColor
  }
  
  fileprivate func selectCellAt(_ indexPath: IndexPath) {
    collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    
    didSelectDate?(self.dates[indexPath.row])
  }
  
  fileprivate func stoppedScrolling() {
    let visiblePaths = collectionView.indexPathsForVisibleItems
    activeIndexPath = visiblePaths.sorted().middle
    if let activePath = activeIndexPath {
      selectCellAt(activePath)
    }
  }
}

// MARK: - UICollectionViewDataSource
extension HorizontalPicker: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return dates.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let dateCell = collectionView.dequeueReusableCell(DateCell.self, forIndexPath: indexPath)
    dateCell.date = dates[indexPath.row]
    return dateCell
  }
}

// MARK: - UICollectionViewDelegate
extension HorizontalPicker: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
    return (indexPath.row < dates.count - 1) && (indexPath.row > 0)
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    selectCellAt(indexPath)
  }
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    stoppedScrolling()
  }
  
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    stoppedScrolling()
  }
  
  func indexPathForPreferredFocusedView(in collectionView: UICollectionView) -> IndexPath? {
    return activeIndexPath
  }
}
