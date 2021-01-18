//
//  AutoInvalidatingLayout.swift
//  tvmaze
//
//  Created by Jorge Armando Torres Perez on 17/01/21.
//

import UIKit

class AutoInvalidatingLayout: UICollectionViewFlowLayout {
    func widestCellWidth(bounds: CGRect) -> CGFloat {
        guard let _ = collectionView else {
            return 0
        }
        return ShowCell.cellWidth
    }

    func updateEstimatedItemSize(bounds: CGRect) {
        estimatedItemSize = CGSize(
            width: widestCellWidth(bounds: bounds),
            height: ShowCell.cellHeight
        )
    }

    override func prepare() {
        super.prepare()

        let bounds = collectionView?.bounds ?? .zero
        updateEstimatedItemSize(bounds: bounds)
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        guard let collectionView = collectionView else {
            return false
        }
        
        let oldSize = collectionView.bounds.size
        guard oldSize != newBounds.size else { return false }
        
        updateEstimatedItemSize(bounds: newBounds)
        return true
    }
}
