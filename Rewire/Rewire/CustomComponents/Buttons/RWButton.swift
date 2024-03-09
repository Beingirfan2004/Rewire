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
    
    
    convenience init(title: String, color: UIColor) {
        self.init(frame: .zero)
        setTitle(title, for: .normal)
        backgroundColor = color
        layer.borderColor = color.cgColor
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        let existingFont            = UIFont.preferredFont(forTextStyle: .title1)
        let fontDescriptor          = existingFont.fontDescriptor
        let boldFontDescriptor      = fontDescriptor.withSymbolicTraits(.traitBold)
        let boldFont                = UIFont(descriptor: boldFontDescriptor!, size: existingFont.pointSize)
        
        titleLabel?.font        = boldFont
        layer.cornerRadius      = 30
        clipsToBounds           = true
        backgroundColor         = .rwBlue
        layer.borderWidth       = 3
        layer.borderColor       = UIColor.systemBlue.cgColor
        setTitleColor(.white, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
        
    }
}
