//
//  RWTimerContainerView.swift
//  Rewire
//
//  Created by Irfan Khan on 31/01/24.
//

import UIKit

protocol RWTimerContainerViewDelegate: AnyObject {
    func updateDaysLabel(days: Int)
}

class RWTimerContainerView: UIView {
    
    let timeCalculator              = TimeCalculator.shared
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
    
    
    weak var delegate               : RWTimerContainerViewDelegate?
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
    
        
        NSLayoutConstraint.activate([
            currentStreakLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            currentStreakLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding * 4),
            currentStreakLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding * 4),
            currentStreakLabel.heightAnchor.constraint(equalToConstant: 40),
                        
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

//MARK: - Updating Labels
extension RWTimerContainerView {
    
    func updateTime(time: (days: Int, hours: Int, min: Int, sec: Int)){
        // This method is used for updating labels every second.
        
        if time.sec <= 9 && time.sec >= 1 {
            currentSecLabel.text = "0\(time.sec)s"
            
        } else if time.sec <= 59 && time.sec >= 10 {
            currentSecLabel.text = "\(time.sec)s"
            
        } else {
            currentSecLabel.text = "0\(time.sec)s"
            
            if time.min <= 9 && time.min >= 1{
                currentMinLabel.text = "0\(time.min)m"
                
            } else if time.min <= 59 && time.min >= 10{
                currentMinLabel.text = "\(time.min)m"
                
            } else {
                currentMinLabel.text = "0\(time.min)m"
                
                if time.hours <= 9 && time.hours >= 1{
                    currentHourLabel.text = "0\(time.hours)h"
                    
                } else if time.hours <= 23 && time.hours >= 10{
                    currentHourLabel.text = "\(time.hours)h"
                    
                } else {
                    currentHourLabel.text = "0\(time.hours)h"
                    
                    delegate?.updateDaysLabel(days: time.days) // Updating days Label on MainTimerVC using delegate communication pattern.
                    
                    if time.days <= 9 {
                        currentDayLabel.text = "0\(time.days)d"
                        
                    } else {
                        currentDayLabel.text = "\(time.days)d"
                        
                    }
                    
                }
                
            }
            
        }
        
        if !timeCalculator.isLongestStreak {
            longestDayLabel.text = currentDayLabel.text
            longestHourLabel.text = currentHourLabel.text
            longestMinLabel.text = currentMinLabel.text
            longestSecLabel.text = currentSecLabel.text
        }
        
    }
    
    func updateStreakUI( result:Result<(days: Int, hours: Int, min: Int, sec: Int), RWError>){
        // This method updates the longest streak labels according to the Result type.
            
            switch result {
            case .success(let time):
                if time.sec <= 9 {
                    longestSecLabel.text = "0\(time.sec)s"
                } else {
                    longestSecLabel.text = "\(time.sec)s"
                }
                
                if time.min <= 9 {
                    longestMinLabel.text = "0\(time.min)m"
                } else {
                    longestMinLabel.text = "\(time.min)m"
                }
                
                if time.hours <= 9 {
                    longestHourLabel.text = "0\(time.hours)h"
                } else {
                    longestHourLabel.text = "\(time.hours)h"
                }
                
                if time.days <= 9 {
                    longestDayLabel.text = "0\(time.days)d"
                } else {
                    longestDayLabel.text = "\(time.days)d"
                }
                
                
            case .failure( _):
                longestDayLabel.text        = currentDayLabel.text
                longestHourLabel.text       = currentHourLabel.text
                longestMinLabel.text        = currentMinLabel.text
                longestSecLabel.text        = currentSecLabel.text
                
            }
    }
    
    func updateOnce( time: (days: Int, hours: Int, min: Int, sec: Int)) {
        // This method updates all the labels from both the streak.
        // Should only be used when both current and longest streaks are the same.
            if time.sec <= 9{
                currentSecLabel.text = "0\(time.sec)s"
            } else {
                currentSecLabel.text = "\(time.sec)s"
            }
            
            if time.min <= 9 {
                currentMinLabel.text = "0\(time.min)m"
            } else {
                currentMinLabel.text = "\(time.min)m"
            }
            
            if time.hours <= 9 {
                currentHourLabel.text = "0\(time.hours)h"
            } else {
                currentHourLabel.text = "\(time.hours)h"
            }
            
            if time.days <= 9 {
                currentDayLabel.text = "0\(time.days)d"
            } else {
                currentDayLabel.text = "\(time.days)d"
            }
            
            if time.days <= 9 {
                longestDayLabel.text = "0\(time.days)d"
            } else {
                longestDayLabel.text = "\(time.days)d"
            }
            
            if time.hours <= 9 {
                longestHourLabel.text = "0\(time.hours)h"
            } else {
                longestHourLabel.text = "\(time.hours)h"
            }
            
            if time.min <= 9 {
                longestMinLabel.text = "0\(time.min)m"
            } else {
                longestMinLabel.text = "\(time.min)m"
            }
            
            if time.sec <= 9 {
                longestSecLabel.text = "0\(time.sec)s"
            } else {
                longestSecLabel.text = "\(time.sec)s"
            }
            
        }
    
    func updateCurrentStreak( time: (days: Int, hours: Int, min: Int, sec: Int)) {
        // This method updates all four labels of current streak.
        if time.sec <= 9{
            currentSecLabel.text = "0\(time.sec)s"
        } else {
            currentSecLabel.text = "\(time.sec)s"
        }
        
        if time.min <= 9 {
            currentMinLabel.text = "0\(time.min)m"
        } else {
            currentMinLabel.text = "\(time.min)m"
        }
        
        if time.hours <= 9 {
            currentHourLabel.text = "0\(time.hours)h"
        } else {
            currentHourLabel.text = "\(time.hours)h"
        }
        
        if time.days <= 9 {
            currentDayLabel.text = "0\(time.days)d"
        } else {
            currentDayLabel.text = "\(time.days)d"
        }
    }
        
}
