//
//  DateAndTimePickerVC.swift
//  Rewire
//
//  Created by Irfan Khan on 07/02/24.
//

import UIKit

protocol DateAndTimePickerVCDelegate {
    func resetButtonTapped(date: Date)
}

class DateAndTimePickerVC: UIViewController {
    var timeCalculator = TimeCalculator()
    var datePicker : RWDatePicker!
    var delegate: DateAndTimePickerVCDelegate!
    let button = RWButton(title: "RESET STREAK", color: .rwPurple)
    let dateLabel = RWTimerLabel(fontSize: 25, fontWeight: .regular, fontColor: .label)
    let timeLabel = RWTimerLabel(fontSize: 25, fontWeight: .regular, fontColor: .label)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker = RWDatePicker()
        configureDatePicker()
        configureButton()
        configureLabels()
        view.backgroundColor = .systemBackground
    }
    
    
    @objc func updateLabels() {
        dateLabel.text = datePicker.onlyDate
        timeLabel.text = datePicker.onlyTime
        
    }
    
    
    @objc func reset() {
        delegate.resetButtonTapped(date: datePicker.selectedDate)
        dismiss(animated: true)
    }
    
    
    private func configureDatePicker() {
        view.addSubview(datePicker)
        datePicker.addTarget(self, action: #selector(updateLabels), for: .valueChanged)
        
        NSLayoutConstraint.activate([
            datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            datePicker.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    
    private func configureButton() {
        view.addSubview(button)
        button.addTarget(self, action: #selector(reset), for: .touchUpInside)
        button.layer.borderColor = UIColor.systemPurple.cgColor
        
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 30),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            button.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    
    private func configureLabels() {
        dateLabel.backgroundColor       = .secondarySystemBackground
        dateLabel.layer.cornerRadius    = 20
        dateLabel.clipsToBounds         = true
        dateLabel.text                  = datePicker.onlyDate
        
        timeLabel.backgroundColor       = .secondarySystemBackground
        timeLabel.layer.cornerRadius    = 20
        timeLabel.clipsToBounds         = true
        timeLabel.text                  = datePicker.onlyTime
        
        
        view.addSubviews(dateLabel, timeLabel)
        
        NSLayoutConstraint.activate([
            dateLabel.bottomAnchor.constraint(equalTo: datePicker.topAnchor, constant: -30),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            dateLabel.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -10),
            dateLabel.heightAnchor.constraint(equalToConstant: 60),
            
            timeLabel.centerYAnchor.constraint(equalTo: dateLabel.centerYAnchor),
            timeLabel.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 10),
            timeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            timeLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    

}
