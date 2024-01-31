//
//  RWButton.swift
//  Rewire
//
//  Created by Irfan Khan on 31/01/24.
//

import UIKit

class RWButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    convenience init(title: String) {
        self.init(frame: .zero)
        setTitle(title, for: .normal)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        layer.cornerRadius      = 30
        clipsToBounds           = true
        backgroundColor         = .rwBlue
        layer.borderWidth       = 3
        layer.borderColor       = UIColor.systemBlue.cgColor
        titleLabel?.font        = UIFont.preferredFont(forTextStyle: .title1)
        setTitleColor(.white, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
        
    }
}
