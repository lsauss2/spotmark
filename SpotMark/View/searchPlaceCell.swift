//
//  searchPlaceCell.swift
//  SpotMark
//
//  Created by Ludovic Saussinan on 21/1/18.
//  Copyright © 2018 Ludovic Saussinan. All rights reserved.
//

import UIKit

class searchPlaceCell: UITableViewCell {
    
    @IBOutlet weak var placeNameLbl: UILabel!
    @IBOutlet weak var placeAddressLbl: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configureCell(place: Place){
        self.placeNameLbl.text = place.placeName
        self.placeAddressLbl.text = place.placeAddress
    }

}
