//
//  CustomTextField.swift
//  SpotMark
//
//  Created by Ludovic Saussinan on 20/1/18.
//  Copyright © 2018 Ludovic Saussinan. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        if let p = placeholder {
            let place = NSAttributedString(string: p, attributes: [.foregroundColor : #colorLiteral(red: 0.6395461559, green: 0.6430392861, blue: 0.7407739162, alpha: 1)])
            attributedPlaceholder = place
            textColor = #colorLiteral(red: 0.3408907652, green: 0.3429274261, blue: 0.3998020589, alpha: 1)
        }
    }

}
