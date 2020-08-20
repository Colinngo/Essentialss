//
//  TabbarVC.swift
//  Essentialss
//
//  Created by QTS Coder on 7/17/20.
//  Copyright © 2020 QTS Coder. All rights reserved.
//

import UIKit

class TabbarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configTabbar()
        if #available(iOS 10, *) {
           UITabBarItem.appearance().badgeColor = .white
        }
        if let notificationItem = self.tabBar.items?[2] {
            if #available(iOS 10.0, *) {
                let attribute : [String : Any] = [NSAttributedStringKey.foregroundColor.rawValue : UIColor.red]
                notificationItem.badgeColor = .white
                notificationItem.setBadgeTextAttributes(attribute, for: .normal)
            }
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    private func configTabbar()
    {
        self.navigationController?.isNavigationBarHidden = true
         self.view.backgroundColor = UIColor.clear
         UITabBar.appearance().shadowImage = UIImage()
         UITabBar.appearance().backgroundImage = UIImage()
         let tab1UnSelect = UIImage.init(named: "ic_home")!.withRenderingMode(.alwaysOriginal)
         let tab1Select = UIImage.init(named: "ic_home_on")!.withRenderingMode(.alwaysOriginal)
         self.tabBar.items?[0].selectedImage = tab1Select
         self.tabBar.items?[0].image = tab1UnSelect
         
        let tab2UnSelect = UIImage.init(named: "ic_categories")!.withRenderingMode(.alwaysOriginal)
        let tab2Select = UIImage.init(named: "ic_categories_on")!.withRenderingMode(.alwaysOriginal)
        self.tabBar.items?[1].selectedImage = tab2Select
        self.tabBar.items?[1].image = tab2UnSelect
         
         let tab3UnSelect = UIImage.init(named: "ic_cart")!.withRenderingMode(.alwaysOriginal)
        let tab3Select = UIImage.init(named: "ic_cart_on")!.withRenderingMode(.alwaysOriginal)
        self.tabBar.items?[2].selectedImage = tab3Select
        self.tabBar.items?[2].image = tab3UnSelect
         
         let tab4UnSelect = UIImage.init(named: "ic_account")!.withRenderingMode(.alwaysOriginal)
        let tab4Select = UIImage.init(named: "ic_account_on")!.withRenderingMode(.alwaysOriginal)
        self.tabBar.items?[3].selectedImage = tab4Select
        self.tabBar.items?[3].image = tab4UnSelect
        
        self.tabBar.tintColor = UIColor.init(patternImage: UIImage.init(named: "tabbar")!)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
    }
}
