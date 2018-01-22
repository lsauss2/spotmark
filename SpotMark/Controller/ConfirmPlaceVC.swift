//
//  ConfirmPlaceVC.swift
//  SpotMark
//
//  Created by Ludovic Saussinan on 22/1/18.
//  Copyright © 2018 Ludovic Saussinan. All rights reserved.
//

import UIKit

class ConfirmPlaceVC: UIViewController {
    
    var place: Place!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(place.placeName)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
