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

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addPlaceFromEmpty (_ sender: Any) {
        performSegue(withIdentifier: "showAddPlaceFromEmpty", sender: nil)
    }
    


}
