//
//  TimeCalculator.swift
//  Rewire
//
//  Created by Irfan Khan on 01/02/24.
//

import Foundation

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



