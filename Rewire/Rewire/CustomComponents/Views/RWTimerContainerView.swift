//
//  RWTimerContainerView.swift
//  Rewire
//
//  Created by Irfan Khan on 31/01/24.
//

import UIKit

class RWTimerContainerView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func configure() {
        layer.cornerRadius      = 20
        layer.shadowColor       = UIColor.black.cgColor
        layer.shadowOpacity     = 0.2
        layer.shadowRadius      = 5
        layer.shadowOffset      = CGSize(width: 0, height: 4) // Adjust the offset as needed
        clipsToBounds           = true
        backgroundColor         = UIColor.secondarySystemBackground
        layer.masksToBounds     = false
        translatesAutoresizingMaskIntoConstraints = false
        
    }
    
}
