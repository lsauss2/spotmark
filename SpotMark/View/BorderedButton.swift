//
//  BorderedButton.swift
//  SpotMark
//
//  Created by Ludovic Saussinan on 21/1/18.
//  Copyright © 2018 Ludovic Saussinan. All rights reserved.
//

import UIKit

class BorderedButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderWidth = 1.0
        layer.borderColor = #colorLiteral(red: 0.3408907652, green: 0.3429274261, blue: 0.3998020589, alpha: 1)
        layer.cornerRadius = 4.0
        clipsToBounds = true
    }

}
