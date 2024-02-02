//
//  MainTimerVC.swift
//  Rewire
//
//  Created by Irfan Khan on 30/01/24.
//

import UIKit

class MainTimerVC: UIViewController {
    
    let daysTimerLabel              = RWTimerLabel(fontSize: 100, fontWeight: .black, fontColor: .white)
    let daysLabel                   = RWTimerLabel(fontSize: 20, fontWeight: .bold, fontColor: .white)
    let daysContainerView           = RWGradientView(color1: .systemPurple, color2: .systemBlue, cornerRadius: 100)
    let timerContainerView          = RWTimerContainerView()
    let currentStreakLabel          = RWTimerTitleLabel(backgroundColor: .systemPurple )
    let currentStreakTimerLabel     = RWTimerLabel()
    let longestStreakLabel          = RWTimerTitleLabel(backgroundColor: .systemPurple )
    let longestStreakTimerlabel     = RWTimerLabel()
    let rightActionButton           = RWButton(title: "Media")
    let leftActionButton            = RWButton(title: "Meditate")
    var longestStreak               : Date!
    var startDate                   : Date!
    var timer                       : Timer?
    var isLongestStreak             : Bool {
        get{
            if let streak = UserDefaults.standard.value(forKey: Constants.isLongestStreak) as? Bool{
                return streak
            } else {
                return false
            }
        } set (newValue){
            UserDefaults.standard.setValue(newValue, forKey: Constants.isLongestStreak)
            calculateStreaks()
            
        }
        
    }
    
    
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
    }
    
    let padding: CGFloat = 20
    
    
    func configure() {
        configureContainerView()
        configureDaysView()
        configureElementsInContainerView()
        configureLeftButton()
        configureRightButton()
        configureBarItem()
    }
    
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        
    }
    
    @objc func updateTime() {
        let elapsedTime = Date().timeIntervalSince(startDate)
        let time = extractComponents(elapsedTime)
        
        currentStreakTimerLabel.text = "\(time.days)d \(time.hours)h \(time.min)m \(time.sec)s"
        
        if !isLongestStreak {
            longestStreakTimerlabel.text = currentStreakTimerLabel.text
        } else {
            
        }
        
    }
    
    
    @objc func topRightButtonTapped() {
        let startAgain = Date()
        
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
        calculateStreaks()
         
    }
    
    
    @objc func leftButtonTapped() {
        
    }
    
    
    @objc func rightButtonTapped() {
        
    }
    
    
    func calculateStreaks() {
        if let savedDate = UserDefaults.standard.value(forKey: Constants.startDate) as? Date{
            startDate = savedDate
            startTimer()
        } else {
            startDate = Date()
            UserDefaults.standard.setValue(startDate, forKey: Constants.startDate)
            startTimer()
        }
        
        if let savedElapsed = UserDefaults.standard.value(forKey: Constants.streak) as? TimeInterval, isLongestStreak{
            let elapsedTime = Date().timeIntervalSince(startDate)
            if savedElapsed > elapsedTime {
                let timeRemaining = savedElapsed - elapsedTime
                DispatchQueue.main.asyncAfter(deadline: .now() + timeRemaining) {
                    self.isLongestStreak = false
                }
                let extractedStreak = extractComponents(savedElapsed)
                longestStreakTimerlabel.text = "\(extractedStreak.days)d \(extractedStreak.hours)h \(extractedStreak.min)m \(extractedStreak.sec)s"
                
            } else {
                 longestStreakTimerlabel.text = currentStreakTimerLabel.text
                 isLongestStreak = false
            }
        }
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
    
    
    func configureElementsInContainerView() {
        timerContainerView.addSubview(currentStreakLabel)
        timerContainerView.addSubview(currentStreakTimerLabel)
        timerContainerView.addSubview(longestStreakLabel)
        timerContainerView.addSubview(longestStreakTimerlabel)
        
        currentStreakLabel.text         = "Current Streak:"
        longestStreakLabel.text         = "Longest Streak:"
        
        NSLayoutConstraint.activate([
            currentStreakLabel.topAnchor.constraint(equalTo: timerContainerView.topAnchor, constant: 20),
            currentStreakLabel.leadingAnchor.constraint(equalTo: timerContainerView.leadingAnchor, constant: padding * 4),
            currentStreakLabel.trailingAnchor.constraint(equalTo: timerContainerView.trailingAnchor, constant: -padding * 4),
            currentStreakLabel.heightAnchor.constraint(equalToConstant: 40),
            
            currentStreakTimerLabel.topAnchor.constraint(equalTo: currentStreakLabel.bottomAnchor, constant: 15),
            currentStreakTimerLabel.leadingAnchor.constraint(equalTo: timerContainerView.leadingAnchor, constant: padding),
            currentStreakTimerLabel.trailingAnchor.constraint(equalTo: timerContainerView.trailingAnchor, constant: -padding),
            currentStreakTimerLabel.heightAnchor.constraint(equalToConstant: 60),
            
            longestStreakLabel.topAnchor.constraint(equalTo: currentStreakTimerLabel.bottomAnchor, constant: 30),
            longestStreakLabel.leadingAnchor.constraint(equalTo: timerContainerView.leadingAnchor, constant: padding * 4),
            longestStreakLabel.trailingAnchor.constraint(equalTo: timerContainerView.trailingAnchor, constant: -padding * 4),
            longestStreakLabel.heightAnchor.constraint(equalToConstant: 40),
            
            longestStreakTimerlabel.topAnchor.constraint(equalTo: longestStreakLabel.bottomAnchor, constant: 15),
            longestStreakTimerlabel.leadingAnchor.constraint(equalTo: timerContainerView.leadingAnchor, constant: padding),
            longestStreakTimerlabel.trailingAnchor.constraint(equalTo: timerContainerView.trailingAnchor, constant: -padding),
            longestStreakTimerlabel.heightAnchor.constraint(equalToConstant: 60)
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
