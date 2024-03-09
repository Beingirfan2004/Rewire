//
//  TimeCalculator.swift
//  Rewire
//
//  Created by Irfan Khan on 01/02/24.
//

import UIKit

protocol TimeCalculatorDelegate {
    func calculateStreaks()
}

class TimeCalculator {
    
    var longestStreak               : Date!
    var startDate                   : Date!
    var delegate                    : TimeCalculatorDelegate!
    var isLongestStreak             : Bool {
        get{
            if let streak = UserDefaults.standard.value(forKey: Constants.isLongestStreak) as? Bool{
                return streak
            } else {
                return false
            }
        } set (newValue){
            UserDefaults.standard.setValue(newValue, forKey: Constants.isLongestStreak)
            delegate.calculateStreaks()
            
        }
        
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

            return (days,hours, minutes, seconds)
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

    
    func updateDate() {
        if let savedDate = UserDefaults.standard.value(forKey: Constants.startDate) as? Date{
            startDate = savedDate
        } else {
            startDate = Date()
            UserDefaults.standard.setValue(startDate, forKey: Constants.startDate)
        }
    }
    
    
    func updateStreak()  -> Result<(days:Int, hours: Int, min: Int, sec: Int), RWError> {
        if let savedElapsed = UserDefaults.standard.value(forKey: Constants.streak) as? TimeInterval, isLongestStreak{
            let elapsedTime = Date().timeIntervalSince(startDate)
            if savedElapsed > elapsedTime {
                let timeRemaining = savedElapsed - elapsedTime
                DispatchQueue.main.asyncAfter(deadline: .now() + timeRemaining) {
                    self.isLongestStreak = false
                }
                let extractedStreak = extractComponents(savedElapsed)
                return (.success(extractedStreak))
                
                
            } else {
                isLongestStreak = false
                return (.failure(.notLongestStreak))
            }
        }
        return (.failure(.notLongestStreak))
    }
    
    func resetStreak(date: Date) {
        let startAgain = date
        
        guard let newStreak = UserDefaults.standard.value(forKey: Constants.startDate) as? Date else {
            return
        }
        
        let newElapsed = Date().timeIntervalSince(newStreak)
        
        guard let oldElapsed = UserDefaults.standard.value(forKey: Constants.streak) as? TimeInterval else {
            UserDefaults.standard.setValue(startAgain, forKey: Constants.startDate)
            startDate = startAgain
            UserDefaults.standard.setValue(newElapsed, forKey: Constants.streak)
            isLongestStreak = true
            return
        }
        
        guard newElapsed >= oldElapsed else {
            UserDefaults.standard.setValue(startAgain, forKey: Constants.startDate)
            startDate = startAgain
            isLongestStreak = true
            return
        }
        
        UserDefaults.standard.setValue(startAgain, forKey: Constants.startDate)
        startDate = startAgain
        UserDefaults.standard.setValue(newElapsed, forKey: Constants.streak)
        isLongestStreak = true
         
    }

}



