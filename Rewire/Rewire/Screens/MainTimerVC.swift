//
//  MainTimerVC.swift
//  Rewire
//
//  Created by Irfan Khan on 30/01/24.
//

import UIKit

class MainTimerVC: UIViewController{
    var timeCalculator              = TimeCalculator.shared
    let daysTimerLabel              = RWTimerLabel(fontSize: 100, fontWeight: .black, fontColor: .white)
    let daysLabel                   = RWTimerLabel(fontSize: 20, fontWeight: .bold, fontColor: .white)
    let daysContainerView           = RWGradientView(color1: .systemPurple, color2: .systemBlue, cornerRadius: 100)
    let timerContainerView          = RWTimerContainerView()
    let rightActionButton           = RWButton(title: "Media")
    let leftActionButton            = RWButton(title: "Meditate")
    var timer                       : Timer?
    let datePickerVC                = DateAndTimePickerVC()

    let padding: CGFloat = 20

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configure() 
        let result = timeCalculator.updateStreaks()
        timerContainerView.updateStreakUI(result: result)
        startTimer()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.barTintColor = .secondarySystemBackground
        
        let result = timeCalculator.updateStreaks()
        timerContainerView.updateStreakUI(result: result)
    }
    
        
    func configure() {
        configureContainerView()
        configureDaysView()
        configureLeftButton()
        configureRightButton()
        configureBarItem()
        datePickerVC.delegate = self
        timeCalculator.delegate = self
        timerContainerView.delegate = self
    }
    
    
    func startTimer() {
        updateTime()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    
    @objc func updateTime() {
        let result = timeCalculator.extractComponents(Date().timeIntervalSince(timeCalculator.startStreakDate))
        timerContainerView.updateTime(time: result)
    }
    
    
    @objc func topRightButtonTapped() {
        
        present(datePickerVC, animated: true)
        datePickerVC.datePicker.maximumDate = Date()
        datePickerVC.datePicker.selectedDate = Date()
        
    }
    
    
    @objc func leftButtonTapped() {
                
    }
    
    
    @objc func rightButtonTapped() {
        
    }
    
    
    func configureBarItem() {
        let topRightActionButton = UIBarButtonItem(image: UIImage(systemName: Constants.thumbImage), style: .plain, target: self,   action:#selector(topRightButtonTapped))
        navigationItem.rightBarButtonItem = topRightActionButton
    }

    
    func configureContainerView() {
        view.addSubview(timerContainerView)
        
        NSLayoutConstraint.activate([
            timerContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50),
            timerContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding * 1.5),
            timerContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding * 1.5),
            timerContainerView.heightAnchor.constraint(equalToConstant: 290)
        ])

    }
    
    
    func configureDaysView() {
        view.addSubview(daysContainerView)
        daysContainerView.addSubview(daysTimerLabel)
        daysContainerView.addSubview(daysLabel)
        
        daysLabel.text      = "DAYS"
        daysTimerLabel.text = "8"
        daysTimerLabel.adjustsFontSizeToFitWidth = true
        
        NSLayoutConstraint.activate([
            daysContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            daysContainerView.heightAnchor.constraint(equalToConstant: 200),
            daysContainerView.widthAnchor.constraint(equalTo: daysContainerView.heightAnchor),
            daysContainerView.bottomAnchor.constraint(equalTo: timerContainerView.topAnchor, constant: -30),
            
            daysTimerLabel.topAnchor.constraint(equalTo: daysContainerView.topAnchor, constant: 40),
            daysTimerLabel.leadingAnchor.constraint(equalTo: daysContainerView.leadingAnchor, constant: padding ),
            daysTimerLabel.trailingAnchor.constraint(equalTo: daysContainerView.trailingAnchor, constant: -padding),
            daysTimerLabel.heightAnchor.constraint(equalToConstant: 100),
            
            daysLabel.topAnchor.constraint(equalTo: daysTimerLabel.bottomAnchor, constant: -8),
            daysLabel.leadingAnchor.constraint(equalTo: daysContainerView.leadingAnchor),
            daysLabel.trailingAnchor.constraint(equalTo: daysContainerView.trailingAnchor),
            daysLabel.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    
    func configureLeftButton() {
        view.addSubview(leftActionButton)
        leftActionButton.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            leftActionButton.topAnchor.constraint(equalTo: timerContainerView.bottomAnchor, constant: 25),
            leftActionButton.leadingAnchor.constraint(equalTo: timerContainerView.leadingAnchor),
            leftActionButton.heightAnchor.constraint(equalToConstant: 60),
            leftActionButton.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    
    func configureRightButton() {
        view.addSubview(rightActionButton)
        rightActionButton.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            rightActionButton.topAnchor.constraint(equalTo: timerContainerView.bottomAnchor, constant: 25),
            rightActionButton.trailingAnchor.constraint(equalTo: timerContainerView.trailingAnchor),
            rightActionButton.heightAnchor.constraint(equalToConstant: 60),
            rightActionButton.widthAnchor.constraint(equalToConstant: 160)
        ])
    }
}


//MARK: - DateAndTimePickerVCDelegate
extension MainTimerVC: DateAndTimePickerVCDelegate {
    func resetButtonTapped(date: Date) {
        let result = timeCalculator.resetBothStreak(date: date)
        timerContainerView.updateStreakUI(result: result)
    }
}


//MARK: - TimeCalculatorDelegate
extension MainTimerVC: TimeCalculatorDelegate {
    func updateCurrent(date: Date) {
        let time = timeCalculator.extractComponents(Date().timeIntervalSince(date))
        daysTimerLabel.text = "\(time.days)"
        timerContainerView.updateCurrentStreak(time: time)

    }
    
    func updateStreaks(date: Date) {
        let time = timeCalculator.extractComponents(Date().timeIntervalSince(date))
        daysTimerLabel.text = "\(time.days)"
        timerContainerView.updateOnce(time: time)
    }
}


//MARK: - RWTimerContainerViewDelegate
extension MainTimerVC: RWTimerContainerViewDelegate {
    func updateDaysLabel(days: Int) {
        daysTimerLabel.text = "\(days)"
    }
}

