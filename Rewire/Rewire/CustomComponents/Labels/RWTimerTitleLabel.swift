//
//  RWTimerTitleLabel.swift
//  Rewire
//
//  Created by Irfan Khan on 31/01/24.
//

import UIKit

class RWTimerTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    convenience init(backgroundColor: UIColor) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        textColor           = .white
        layer.cornerRadius  = 18
        clipsToBounds       = true
        textAlignment       = .center
        font                = UIFont.systemFont(ofSize: 20, weight: .bold)
        translatesAutoresizingMaskIntoConstraints = false 
    }
}
