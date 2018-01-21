//
//  ShadowView.swift
//  SpotMark
//
//  Created by Ludovic Saussinan on 21/1/18.
//  Copyright © 2018 Ludovic Saussinan. All rights reserved.
//

import UIKit

class ShadowView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowRadius = 10
        layer.shadowColor = #colorLiteral(red: 0.3408907652, green: 0.3429274261, blue: 0.3998020589, alpha: 1)
        layer.shadowOpacity = 0.1
    }

}
