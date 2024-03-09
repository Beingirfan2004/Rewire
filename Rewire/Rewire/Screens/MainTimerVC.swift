//
//  MainTimerVC.swift
//  Rewire
//
//  Created by Irfan Khan on 30/01/24.
//

import UIKit

class MainTimerVC: UIViewController , TimeCalculatorDelegate{
    
    var timeCalculator              = TimeCalculator()
    let daysTimerLabel              = RWTimerLabel(fontSize: 100, fontWeight: .black, fontColor: .white)
    let daysLabel                   = RWTimerLabel(fontSize: 20, fontWeight: .bold, fontColor: .white)
    let daysContainerView           = RWGradientView(color1: .systemPurple, color2: .systemBlue, cornerRadius: 100)
    let timerContainerView          = RWTimerContainerView()
    let rightActionButton           = RWButton(title: "Media")
    let leftActionButton            = RWButton(title: "Meditate")
    var timer                       : Timer?
    let mainTimerUIUpdater          = MainTimerUIUpdater()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configure()
        calculateStreaks()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.barTintColor = .secondarySystemBackground
        updateOnce()
    }
    
    let padding: CGFloat = 20
    
    
    func configure() {
        configureContainerView()
        configureDaysView()
        configureLeftButton()
        configureRightButton()
        configureBarItem()
        timeCalculator.delegate = self
    }
    
    
    func updateOnce() {
        let elapsedTime = Date().timeIntervalSince(timeCalculator.startDate)
        let time = timeCalculator.extractComponents(elapsedTime)
        daysTimerLabel.text        = "\(time.days)"
        let oldStreak = UserDefaults.standard.value(forKey: Constants.streak) as? TimeInterval

        mainTimerUIUpdater.updateOnce(
            time: time,
            currentDayLabel: timerContainerView.currentDayLabel,
            currentHourLabel: timerContainerView.currentHourLabel,
            currentMinLabel: timerContainerView.currentMinLabel,
            currentSecLabel: timerContainerView.currentSecLabel,
            longestDayLabel: timerContainerView.longestDayLabel,
            longestHourLabel: timerContainerView.longestHourLabel,
            longestMinLabel: timerContainerView.longestMinLabel,
            longestSecLabel: timerContainerView.longestSecLabel,
            isLongestStreak: timeCalculator.isLongestStreak,
            oldStreak: oldStreak)
    }
    
    
    func startTimer() {
        updateTime()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    
    @objc func updateTime() {
        let elapsedTime = Date().timeIntervalSince(timeCalculator.startDate)
        let time = timeCalculator.extractComponents(elapsedTime)
        
        mainTimerUIUpdater.updateTime(
            time: time,
            currentDayLabel: timerContainerView.currentDayLabel,
            currentHourLabel: timerContainerView.currentHourLabel,
            currentMinLabel: timerContainerView.currentMinLabel,
            currentSecLabel: timerContainerView.currentSecLabel,
            longestDayLabel: timerContainerView.longestDayLabel,
            longestHourLabel: timerContainerView.longestHourLabel,
            longestMinLabel: timerContainerView.longestMinLabel,
            longestSecLabel: timerContainerView.longestSecLabel,
            daysTimerLabel: daysTimerLabel,
            isLongestStreak: timeCalculator.isLongestStreak)
    }
    
    
    @objc func topRightButtonTapped() {
        let datePickerVC = DateAndTimePickerVC()
        present(datePickerVC, animated: true)
    }
    
    
    @objc func leftButtonTapped() {
                
    }
    
    
    @objc func rightButtonTapped() {
        
    }
    
    
    func calculateStreaks() {
        
        timeCalculator.updateDate()
        startTimer()
        let result = timeCalculator.updateStreak()
        
        mainTimerUIUpdater.updateStreakUI(
            result: result,
            longestDayLabel: timerContainerView.longestDayLabel,
            longestHourLabel: timerContainerView.longestHourLabel,
            longestMinLabel: timerContainerView.longestMinLabel,
            longestSecLabel: timerContainerView.longestSecLabel,
            currentDayLabel: timerContainerView.currentDayLabel,
            currentHourLabel: timerContainerView.currentHourLabel,
            currentMinLabel: timerContainerView.currentMinLabel,
            currentSecLabel: timerContainerView.currentSecLabel)
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
