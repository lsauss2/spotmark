//
//  CircleButton.swift
//  SpotMark
//
//  Created by Ludovic Saussinan on 24/1/18.
//  Copyright © 2018 Ludovic Saussinan. All rights reserved.
//

import UIKit

class CircleButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = self.frame.width / 2
    }

}
