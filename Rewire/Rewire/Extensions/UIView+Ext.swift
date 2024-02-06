//
//  UIView+Ext.swift
//  Rewire
//
//  Created by Irfan Khan on 03/02/24.
//

import UIKit


extension UIView {
    
    func addSubviews(_ views: UIView...) {
        for view in views {
            self.addSubview(view)
        }
    }
}
