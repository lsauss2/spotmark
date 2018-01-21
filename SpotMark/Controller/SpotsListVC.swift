//
//  SpotsListVC.swift
//  SpotMark
//
//  Created by Ludovic Saussinan on 21/1/18.
//  Copyright © 2018 Ludovic Saussinan. All rights reserved.
//

import UIKit

class SpotsListVC: UIViewController {
    
    @IBOutlet weak var emptyImage: UIImageView!
    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var emptyButton: CustomButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarController?.tabBar.layer.shadowOffset = CGSize(width: 0, height: 1)
        tabBarController?.tabBar.layer.shadowRadius = 2
        tabBarController?.tabBar.layer.shadowColor = #colorLiteral(red: 0.3408907652, green: 0.3429274261, blue: 0.3998020589, alpha: 1)
        tabBarController?.tabBar.layer.shadowOpacity = 0.3
        tabBarController?.tabBar.unselectedItemTintColor = #colorLiteral(red: 0.6395461559, green: 0.6430392861, blue: 0.7407739162, alpha: 1)
        
        tabBarController?.delegate = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}

extension SpotsListVC: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController.title == "Add Place" {
            return false
        }
        return true
    }
    
}
