//
//  UIScreen.swift
//  tvmaze
//
//  Created by Jorge Armando Torres Perez on 17/01/21.
//

import UIKit

extension UIScreen {

    static func widthOfSafeArea() -> CGFloat {
        guard let rootView = UIApplication.shared.windows.first else { return 0 }
        if #available(iOS 11.0, *) {
            let leftInset = rootView.safeAreaInsets.left
            let rightInset = rootView.safeAreaInsets.right
            return rootView.bounds.width - leftInset - rightInset
        }
        else {
            return rootView.bounds.width
        }
    }
}
