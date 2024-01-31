//
//  RWGradientView.swift
//  Rewire
//
//  Created by Irfan Khan on 31/01/24.
//

import UIKit

class RWGradientView: UIView {
    
    let gradientLayer = CAGradientLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    convenience init(color1: UIColor, color2: UIColor, cornerRadius: CGFloat) {
        self.init(frame: .zero)
        gradientLayer.colors    = [color1.cgColor, color2.cgColor]
        layer.cornerRadius      = cornerRadius
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func configure() {
        layer.shadowColor       = UIColor.black.cgColor
        layer.shadowOpacity     = 0.3
        layer.shadowRadius      = 5
        layer.shadowOffset      = CGSize(width: 0, height: 4) // Adjust the offset as needed
        layer.cornerRadius      = 100
        clipsToBounds           = true
        layer.masksToBounds     = false
        translatesAutoresizingMaskIntoConstraints = false
        
        gradientLayer.colors = [UIColor.systemPurple.cgColor, UIColor.systemBlue.cgColor]
        
        gradientLayer.startPoint    = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint      = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.cornerRadius  = 100
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }

}
