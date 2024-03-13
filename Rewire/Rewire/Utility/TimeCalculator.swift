//
//  TimeCalculator.swift
//  Rewire
//
//  Created by Irfan Khan on 01/02/24.
//

import UIKit

protocol TimeCalculatorDelegate: AnyObject {
    func updateStreaks(date: Date)
    func updateCurrent(date: Date)
}

class TimeCalculator {
    static let shared               = TimeCalculator()
    
    let defaults                    = UserDefaults.standard
    var longestElapsed              : TimeInterval?
    var startStreakDate             : Date!
    weak var delegate               : TimeCalculatorDelegate?
    var isLongestStreak             : Bool {
        get{
            if let bool = defaults.object(forKey: Constants.isLongestStreak) as? Bool {
                return bool
            } else {
                return false
            }
        }
        set(newValue){
            if newValue == false {
                longestElapsed = nil
                defaults.set(longestElapsed, forKey: Constants.longestElapsed)
            }
            defaults.set(newValue, forKey: Constants.isLongestStreak)
        }
    }
    
    
    func resetBothStreak(date: Date) -> Result<(days: Int, hours: Int, min: Int, sec: Int), RWError> {
        let startElapsed = Date().timeIntervalSince(startStreakDate)
        let calenderElapsed = Date().timeIntervalSince(date)
        
        // When the current streak is the longest streak.
        if !isLongestStreak {
            // When the ongoing streak is greater than the recent reset of the streak.
            if startElapsed > calenderElapsed {
                updateLongestElapsed(elapsed: startElapsed)
                updateCurrentStreakDate(date: date)
                delegate?.updateCurrent(date: date)
                return startCountDown()
                
            } else {
                // When the date selected for reset is older than the current streak.
                isLongestStreak = false
                updateCurrentStreakDate(date: date)
                delegate?.updateStreaks(date: date)
                return startCountDown()
                
            }
        } else {
            // When the current streak is not the longest streak and there exists a longest streak.
            guard let longestElapsed else {
                // If isLongestStreak is true than there must be a longestElapsed(longestStreak).
                fatalError("Longest Elapsed is nil !!! ")
            }
            // When the date selected for reset is older than the current longest streak.
            if calenderElapsed > longestElapsed {
                isLongestStreak = false
                updateCurrentStreakDate(date: date)
                delegate?.updateStreaks(date: date)
                return startCountDown()
            } else {
                // When the date selected is not older than the longestStreak, longestStreak is valid.
                updateLongestElapsed(elapsed: longestElapsed)
                updateCurrentStreakDate(date: date)
                delegate?.updateCurrent(date: date)
                return startCountDown()
            }
        }
        
    }
    
    
    func updateStreaks() -> Result<(days: Int, hours: Int, min: Int, sec: Int), RWError> {
        // This method configures both CurrentStreak date and LongestStreak TimeInterval and updates the UI.
        
        updateLongestElapsed()
        updateCurrentStreakDate()
        delegate?.updateCurrent(date: startStreakDate)
        return startCountDown()
    }
    
    
    func startCountDown() -> Result<(days: Int, hours: Int, min: Int, sec: Int), RWError> {
        // This method checks if there is any longest streak and returns a tuple of result type to update the longest streak labels accordingly.
        
        if !isLongestStreak {
            return (.failure(.notLongestStreak))
        } else {
            let startElapsed = Date().timeIntervalSince(startStreakDate)
            guard let longestElapsed else {
                return (.failure(.notLongestStreak))
            }
            let timeRemaining = longestElapsed - startElapsed
            DispatchQueue.main.asyncAfter(deadline: .now() + timeRemaining ) {[weak self] in
                guard let self else { return }
                
                self.isLongestStreak = false
                self.defaults.set(longestElapsed, forKey: Constants.longestElapsed)
            }
            let streak = extractComponents(longestElapsed)
            return (.success(streak))
        }
    }
    
    
    func updateLongestElapsed(elapsed: TimeInterval? = nil) {
        // If elapsed parameter is given then this method updates the longestElapsed variable as the paramter.
        // Else it checks for streak in UserDefaults and then updates the variable.
        // Otherwise it is set to nil.
        
        guard let elapsed else {
            if let streak = defaults.object(forKey: Constants.longestElapsed) as? TimeInterval {
                longestElapsed = streak
                isLongestStreak = true
            } else {
                isLongestStreak = false
                defaults.set(longestElapsed, forKey: Constants.longestElapsed)
            }
            return
        }
        longestElapsed = elapsed
        isLongestStreak = true
        defaults.set(longestElapsed, forKey: Constants.longestElapsed)
        
    }
    
    
    func updateCurrentStreakDate(date: Date? = nil) {
        // This method updates the current streak date same as the updateLongestElapsed method(given above).
        // The only difference is if there is no current streak found then it is set to current Date().
        
        guard let date else {
            if let savedDate = defaults.value(forKey: Constants.startStreakDate) as? Date{
                startStreakDate = savedDate
            } else {
                startStreakDate = Date()
                defaults.set(startStreakDate, forKey: Constants.startStreakDate)
            }
            return
        }
        startStreakDate = date
        defaults.set(startStreakDate, forKey: Constants.startStreakDate)
    }

    
    func extractComponents(_ interval: TimeInterval) -> (days: Int, hours: Int, min: Int, sec: Int){
        let dateComponent = DateComponents(second: Int(interval))
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day ,.hour, .minute, .second], from: Date(), to: calendar.date(byAdding: dateComponent, to: Date())!)

            // Extract the components
        let days = components.day ?? 00
            let hours = components.hour ?? 00
            let minutes = components.minute ?? 00
            let seconds = components.second ?? 00

            return (days ,hours ,minutes ,seconds)
    }
    
    
    func extractSecComponent(_ interval: TimeInterval) -> Int{
        let dateComponent = DateComponents(second: Int(interval))
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day ,.hour, .minute, .second], from: Date(), to: calendar.date(byAdding: dateComponent, to: Date())!)

            // Extract the component
            let seconds = components.second ?? 00

           return seconds
    }
    
    
    func extractMinComponent(_ interval: TimeInterval) -> Int{
        let dateComponent = DateComponents(second: Int(interval))
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day ,.hour, .minute, .second], from: Date(), to: calendar.date(byAdding: dateComponent, to: Date())!)

            // Extract the component
            let minutes = components.minute ?? 00

           return minutes
    }
    
    
    func extractHourComponent(_ interval: TimeInterval) -> Int{
        let dateComponent = DateComponents(second: Int(interval))
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day ,.hour, .minute, .second], from: Date(), to: calendar.date(byAdding: dateComponent, to: Date())!)

            // Extract the component
            let hours = components.hour ?? 00

           return hours
    }
    
    
    func extractDayComponent(_ interval: TimeInterval) -> Int{
        let dateComponent = DateComponents(second: Int(interval))
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day ,.hour, .minute, .second], from: Date(), to: calendar.date(byAdding: dateComponent, to: Date())!)

            // Extract the component
            let days = components.day ?? 00
           return days
    }


}





