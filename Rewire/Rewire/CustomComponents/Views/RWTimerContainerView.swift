//
//  RWTimerContainerView.swift
//  Rewire
//
//  Created by Irfan Khan on 31/01/24.
//

import UIKit

class RWTimerContainerView: UIView {
    
    let currentStreakLabel          = RWTimerTitleLabel(backgroundColor: .systemPurple )
    let currentDayLabel             = RWTimerLabel()
    let currentHourLabel            = RWTimerLabel()
    let currentMinLabel             = RWTimerLabel()
    let currentSecLabel             = RWTimerLabel()
    let longestStreakLabel          = RWTimerTitleLabel(backgroundColor: .systemPurple )
    let longestDayLabel             = RWTimerLabel()
    let longestHourLabel            = RWTimerLabel()
    let longestMinLabel             = RWTimerLabel()
    let longestSecLabel             = RWTimerLabel()
    
    var padding: CGFloat            = 20

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
        configureElementsInContainerView()
        
    }
    
    
    func configureElementsInContainerView() {
        self.addSubviews(
            currentStreakLabel,
            currentDayLabel,
            currentHourLabel,
            currentMinLabel,
            currentSecLabel,
            longestStreakLabel,
            longestDayLabel,
            longestHourLabel,
            longestMinLabel,
            longestSecLabel
        )
        
        
        currentStreakLabel.text         = "Current Streak:"
        currentHourLabel.text           = "00h"
        currentMinLabel.text            = "00m"
        currentSecLabel.text            = "00s"
        currentDayLabel.text            = "00d"
        longestStreakLabel.text         = "Longest Streak:"
        longestHourLabel.text           = "00h"
        longestMinLabel.text            = "00m"
        longestSecLabel.text            = "00s"
        longestDayLabel.text            = "00d"
        
        currentDayLabel.textAlignment   = .right
        currentSecLabel.textAlignment   = .left
        longestDayLabel.textAlignment   = .right
        longestSecLabel.textAlignment   = .left
//        currentHourLabel.textAlignment  = .right
//        currentMinLabel.textAlignment   = .left
//        longestHourLabel.textAlignment  = .right
//        longestMinLabel.textAlignment  = .left
        
        
        NSLayoutConstraint.activate([
            currentStreakLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            currentStreakLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding * 4),
            currentStreakLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding * 4),
            currentStreakLabel.heightAnchor.constraint(equalToConstant: 40),
            
//            currentStreakTimerLabel.topAnchor.constraint(equalTo: currentStreakLabel.bottomAnchor, constant: 15),
//            currentStreakTimerLabel.leadingAnchor.constraint(equalTo: timerContainerView.leadingAnchor, constant: padding),
//            currentStreakTimerLabel.trailingAnchor.constraint(equalTo: timerContainerView.trailingAnchor, constant: -padding),
//            currentStreakTimerLabel.heightAnchor.constraint(equalToConstant: 60),
            
            currentHourLabel.topAnchor.constraint(equalTo: currentStreakLabel.bottomAnchor, constant: 15),
            currentHourLabel.trailingAnchor.constraint(equalTo: self.centerXAnchor, constant: -3),
            currentHourLabel.widthAnchor.constraint(equalToConstant: 60),
            currentHourLabel.heightAnchor.constraint(equalToConstant: 60),
            
            currentMinLabel.topAnchor.constraint(equalTo: currentStreakLabel.bottomAnchor, constant: 15),
            currentMinLabel.leadingAnchor.constraint(equalTo: self.centerXAnchor, constant: 3),
            currentMinLabel.widthAnchor.constraint(equalToConstant: 70),
            currentMinLabel.heightAnchor.constraint(equalToConstant: 60),
            
            currentSecLabel.topAnchor.constraint(equalTo: currentStreakLabel.bottomAnchor, constant: 15),
            currentSecLabel.leadingAnchor.constraint(equalTo: currentMinLabel.trailingAnchor, constant: 6),
            currentSecLabel.widthAnchor.constraint(equalToConstant: 70),
            currentSecLabel.heightAnchor.constraint(equalToConstant: 60),
            
            currentDayLabel.topAnchor.constraint(equalTo: currentStreakLabel.bottomAnchor, constant: 15),
            currentDayLabel.trailingAnchor.constraint(equalTo: currentHourLabel.leadingAnchor, constant: -6),
            currentDayLabel.widthAnchor.constraint(equalToConstant: 100),
            currentDayLabel.heightAnchor.constraint(equalToConstant: 60),

            longestStreakLabel.topAnchor.constraint(equalTo: currentHourLabel.bottomAnchor, constant: 30),
            longestStreakLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding * 4),
            longestStreakLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding * 4),
            longestStreakLabel.heightAnchor.constraint(equalToConstant: 40),
            
//            longestStreakTimerlabel.topAnchor.constraint(equalTo: longestStreakLabel.bottomAnchor, constant: 15),
//            longestStreakTimerlabel.leadingAnchor.constraint(equalTo: timerContainerView.leadingAnchor, constant: padding),
//            longestStreakTimerlabel.trailingAnchor.constraint(equalTo: timerContainerView.trailingAnchor, constant: -padding),
//            longestStreakTimerlabel.heightAnchor.constraint(equalToConstant: 60)
            
            longestHourLabel.topAnchor.constraint(equalTo: longestStreakLabel.bottomAnchor, constant: 15),
            longestHourLabel.trailingAnchor.constraint(equalTo: self.centerXAnchor, constant: -3),
            longestHourLabel.widthAnchor.constraint(equalToConstant: 60),
            longestHourLabel.heightAnchor.constraint(equalToConstant: 60),
            
            longestMinLabel.topAnchor.constraint(equalTo: longestStreakLabel.bottomAnchor, constant: 15),
            longestMinLabel.leadingAnchor.constraint(equalTo: self.centerXAnchor, constant: 3),
            longestMinLabel.widthAnchor.constraint(equalToConstant: 70),
            longestMinLabel.heightAnchor.constraint(equalToConstant: 60),
            
            longestSecLabel.topAnchor.constraint(equalTo: longestStreakLabel.bottomAnchor, constant: 15),
            longestSecLabel.leadingAnchor.constraint(equalTo: longestMinLabel.trailingAnchor, constant: 6),
            longestSecLabel.widthAnchor.constraint(equalToConstant: 70),
            longestSecLabel.heightAnchor.constraint(equalToConstant: 60),
            
            longestDayLabel.topAnchor.constraint(equalTo: longestStreakLabel.bottomAnchor, constant: 15),
            longestDayLabel.trailingAnchor.constraint(equalTo: longestHourLabel.leadingAnchor, constant: -6),
            longestDayLabel.widthAnchor.constraint(equalToConstant: 100),
            longestDayLabel.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
    
}
