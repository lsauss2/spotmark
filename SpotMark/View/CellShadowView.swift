//
//  CellShadowView.swift
//  SpotMark
//
//  Created by Ludovic Saussinan on 24/1/18.
//  Copyright © 2018 Ludovic Saussinan. All rights reserved.
//

import UIKit

class CellShadowView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 4.0
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 50
        self.layer.shadowOffset = CGSize(width: 0.0, height: 10.0)
        
    }

}
