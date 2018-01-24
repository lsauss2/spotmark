//
//  placeCell.swift
//  SpotMark
//
//  Created by Ludovic Saussinan on 24/1/18.
//  Copyright © 2018 Ludovic Saussinan. All rights reserved.
//

import UIKit
import CoreLocation

class placeCell: UITableViewCell {

    @IBOutlet weak var mainView: CellShadowView!
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var directionsButton: CircleButton!
    @IBOutlet weak var placeTitle: UILabel!
    @IBOutlet weak var placeType: UILabel!
    @IBOutlet weak var placeStatus: UILabel!
    @IBOutlet weak var placeDistance: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func formatDistance(distance:CLLocationDistance) -> String {
        var floatDistance = Double(distance)
        if floatDistance > 1000.0 {
        floatDistance = floatDistance / 1000
        floatDistance = Double(round(10*floatDistance)/10)
        return "\(floatDistance) km from you"
        } else {
        floatDistance = round(floatDistance)
        return "\(Int(floatDistance)) m from you"
        }
    }
    
    func configureCell(place: Place, userLocation: Dictionary<String,Float>) {
        self.placeTitle.text = place.placeName
        self.placeType.text = place.placeType.uppercased()
        self.placeStatus.text = "Open Now"
        
        let coordinatePlace = CLLocation(latitude: CLLocationDegrees(place.placeLatitude), longitude: CLLocationDegrees(place.placeLongitude))
        let coordinateUser = CLLocation(latitude: CLLocationDegrees(userLocation["lat"]!), longitude: CLLocationDegrees(userLocation["lon"]!))
        let distanceInMeters = coordinatePlace.distance(from: coordinateUser)
        let finalDistance = formatDistance(distance: distanceInMeters)
        self.placeDistance.text = finalDistance
        
        let placePhotoReference = place.placePhotoReference
        let photoUrl = "\(base_photos_url)key=\(api_key)&photoreference=\(placePhotoReference)&maxwidth=400"
        
        if let url = NSURL(string: photoUrl) {
            if let data = NSData(contentsOf: url as URL) {
                self.placeImage.image = UIImage(data: data as Data)
            }
        }
    }

}
