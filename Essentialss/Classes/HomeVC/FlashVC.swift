//
//  FlashVC.swift
//  Essentialss
//
//  Created by Colin Ngo on 8/10/20.
//  Copyright © 2020 QTS Coder. All rights reserved.
//

import UIKit

class FlashVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getAllBanner()
        // Do any additional setup after loading the view.
    }
    func getAllBanner()
    {
        ApiHelper.shared.getBannarHomePage { (arrs) in
            if let datas = arrs
            {
                APP_DELEGATE.arrHomes = datas
                
            }
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabbarVC") as! TabbarVC
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
