//
//  MainTimerUIUpdater.swift
//  Rewire
//
//  Created by Irfan Khan on 03/02/24.
//

import UIKit


struct MainTimerUIUpdater {
    
    let timeCalculator = TimeCalculator()
    
    func updateTime(time: (days: Int, hours: Int, min: Int, sec: Int),
                    currentDayLabel: RWTimerLabel,
                    currentHourLabel: RWTimerLabel,
                    currentMinLabel: RWTimerLabel,
                    currentSecLabel: RWTimerLabel,
                    longestDayLabel: RWTimerLabel, 
                    longestHourLabel: RWTimerLabel,
                    longestMinLabel: RWTimerLabel,
                    longestSecLabel: RWTimerLabel,
                    daysTimerLabel: RWTimerLabel,
                    isLongestStreak: Bool){
        
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
                    daysTimerLabel.text        = "\(time.days)"
                    
                    if time.days <= 9 {
                        currentDayLabel.text = "0\(time.days)d"
                        
                    } else {
                        currentDayLabel.text = "\(time.days)d"
                        
                    }

                }

            }
            
        }
        
        if !isLongestStreak {
            longestDayLabel.text = currentDayLabel.text
            longestHourLabel.text = currentHourLabel.text
            longestMinLabel.text = currentMinLabel.text
            longestSecLabel.text = currentSecLabel.text
        }

    }
    
    
    func updateStreakUI(
        result:Result<(days: Int, hours: Int, min: Int, sec: Int), RWError>,
        longestDayLabel: RWTimerLabel,
        longestHourLabel: RWTimerLabel,
        longestMinLabel: RWTimerLabel,
        longestSecLabel: RWTimerLabel,
        currentDayLabel: RWTimerLabel,
        currentHourLabel: RWTimerLabel,
        currentMinLabel: RWTimerLabel,
        currentSecLabel: RWTimerLabel ){
        
            switch result {
            case .success(let time):
    //            longestStreakTimerlabel.text = "\(extractedStreak.0)d \(extractedStreak.1)h \(extractedStreak.2)m \(extractedStreak.3)s"
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
    //            longestStreakTimerlabel.text = currentStreakTimerLabel.text
                longestDayLabel.text        = currentDayLabel.text
                longestHourLabel.text       = currentHourLabel.text
                longestMinLabel.text        = currentMinLabel.text
                longestSecLabel.text        = currentSecLabel.text

            }

    }
    
    
    func updateOnce(
        time: (days: Int, hours: Int, min: Int, sec: Int),
        currentDayLabel: RWTimerLabel,
        currentHourLabel: RWTimerLabel,
        currentMinLabel: RWTimerLabel,
        currentSecLabel: RWTimerLabel,
        longestDayLabel: RWTimerLabel,
        longestHourLabel: RWTimerLabel,
        longestMinLabel: RWTimerLabel,
        longestSecLabel: RWTimerLabel,
        isLongestStreak: Bool,
        oldStreak: TimeInterval?) {
            
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
            
            if let oldStreak = oldStreak, isLongestStreak {
                let oldTime = timeCalculator.extractComponents(oldStreak)
                
                if oldTime.days <= 9 {
                    longestDayLabel.text = "0\(oldTime.days)d"
                } else {
                    longestDayLabel.text = "\(oldTime.days)d"
                }
                
                if oldTime.hours <= 9 {
                    longestHourLabel.text = "0\(oldTime.hours)h"
                } else {
                    longestHourLabel.text = "\(oldTime.hours)h"
                }
                
                if oldTime.min <= 9 {
                    longestMinLabel.text = "0\(oldTime.min)m"
                } else {
                    longestMinLabel.text = "\(oldTime.min)m"
                }
                
                if oldTime.sec <= 9 {
                    longestSecLabel.text = "0\(oldTime.sec)s"
                } else {
                    longestSecLabel.text = "\(oldTime.sec)s"
                }
                
                
                
            }
            
            

        
    }
    
    
    
}
