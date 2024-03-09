//
//  RWDatePicker.swift
//  Rewire
//
//  Created by Irfan Khan on 07/02/24.
//

import UIKit

class RWDatePicker: UIDatePicker {
    var selectedDate : Date!
    var onlyDate: String = ""
    var onlyTime: String = ""
    let formatter1 = DateFormatter()
    let formatter2 = DateFormatter()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        datePickerMode = .dateAndTime
        addTarget(self, action: #selector(datePickerValueChanged(_ :)), for: .valueChanged)
        translatesAutoresizingMaskIntoConstraints = false
        date = Date()
        selectedDate = date
        maximumDate = Date()
        preferredDatePickerStyle = .inline
        tintColor = .systemPurple
        timeZone = TimeZone.current
        formatter1.timeZone = TimeZone.current
        formatter2.timeZone = TimeZone.current
        
        formatter1.dateFormat = "d MMM, yyyy"
        formatter2.dateFormat = "h:mm a"
        
        onlyDate = formatter1.string(from: selectedDate)
        onlyTime = formatter2.string(from: selectedDate)
    }
    
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        selectedDate = sender.date
        onlyDate = formatter1.string(from: selectedDate)
        onlyTime = formatter2.string(from: selectedDate)
    }
}
