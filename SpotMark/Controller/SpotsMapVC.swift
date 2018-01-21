//
//  SpotsMapVC.swift
//  SpotMark
//
//  Created by Ludovic Saussinan on 21/1/18.
//  Copyright © 2018 Ludovic Saussinan. All rights reserved.
//

import UIKit

class SpotsMapVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBarController?.tabBar.layer.shadowOffset = CGSize(width: 0, height: 1)
        tabBarController?.tabBar.layer.shadowRadius = 2
        tabBarController?.tabBar.layer.shadowColor = #colorLiteral(red: 0.3408907652, green: 0.3429274261, blue: 0.3998020589, alpha: 1)
        tabBarController?.tabBar.layer.shadowOpacity = 0.5
        tabBarController?.tabBar.unselectedItemTintColor = #colorLiteral(red: 0.6395461559, green: 0.6430392861, blue: 0.7407739162, alpha: 1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
