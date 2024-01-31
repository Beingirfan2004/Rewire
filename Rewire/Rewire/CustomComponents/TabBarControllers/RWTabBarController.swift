//
//  RWTabBarController.swift
//  Rewire
//
//  Created by Irfan Khan on 31/01/24.
//

import UIKit

class RWTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor             = .systemPurple
        UITabBar.appearance().backgroundColor       = .secondarySystemBackground
        self.viewControllers                        = [createMainTimerNC(), createRankNC()]
        
    }
    
    
    func createMainTimerNC() -> UINavigationController {
        let mainTimerVC         = MainTimerVC()
        mainTimerVC.title       = "Rewire"
        mainTimerVC.tabBarItem  = UITabBarItem(title: "Rewire", image: UIImage(systemName: "brain"), tag: 0)
        
        return UINavigationController(rootViewController: mainTimerVC)
    }
    
    
    func createRankNC() -> UINavigationController {
        let rankVC          = RankVC()
        rankVC.title        = "Rank"
        rankVC.tabBarItem   = UITabBarItem(title: "Rank", image: UIImage(systemName: "line.horizontal.star.fill.line.horizontal"), tag: 1)
        
        return UINavigationController(rootViewController: rankVC)
    }
    



}
