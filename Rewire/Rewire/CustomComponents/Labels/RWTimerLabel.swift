//
//  RWTimerLabel.swift
//  Rewire
//
//  Created by Irfan Khan on 31/01/24.
//

import UIKit

class RWTimerLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    convenience init(fontSize: CGFloat, fontWeight: UIFont.Weight, fontColor: UIColor) {
        self.init(frame: .zero)
        font        = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        textColor   = fontColor
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        textColor           = .label
        textAlignment       = .center
        font                = UIFont.systemFont(ofSize: 30, weight: .semibold)
        translatesAutoresizingMaskIntoConstraints = false
    }

}
