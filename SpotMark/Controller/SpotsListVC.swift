//
//  SpotsListVC.swift
//  SpotMark
//
//  Created by Ludovic Saussinan on 21/1/18.
//  Copyright © 2018 Ludovic Saussinan. All rights reserved.
//

import UIKit
import CoreLocation
import Firebase

class SpotsListVC: UIViewController {
    
    let locationManager = CLLocationManager()
    var userLatitude = CLLocationDegrees()
    var userLongitude = CLLocationDegrees()
    
    var userPlaces = [Place]()
    
    @IBOutlet weak var emptyImage: UIImageView!
    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var emptyButton: CustomButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest // You can change the locaiton accuary here.
            locationManager.startUpdatingLocation()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getUserPlace {
            if self.userPlaces.count != 0 {
                self.tableView.isHidden = false
                self.emptyImage.isHidden = true
                self.emptyLabel.isHidden = true
                self.emptyButton.isHidden = true
            } else {
                self.tableView.isHidden = true
                self.emptyImage.isHidden = false
                self.emptyLabel.isHidden = false
                self.emptyButton.isHidden = false
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addPlaceFromEmpty (_ sender: Any) {
        performSegue(withIdentifier: "showAddPlaceFromEmpty", sender: nil)
    }
    
    func getUserPlace(completed: @escaping DownloadComplete){
        
        userPlaces.removeAll()
        DataService.instance.REF_PLACES.observe(.value, with: { (snapshot) in
            
            if let snapshots = snapshot.children.allObjects as? [DataSnapshot] {
                
                for snap in snapshots {
                    
                    let id = snap.key as! String
                    
                    if let postDict = snap.value as? Dictionary<String, Any> {
                        let name = postDict["name"] as! String
                        let address = postDict["address"] as! String
                        let photo_reference = postDict["photo"] as! String
                        let rating = postDict["rating"] as! Double
                        let category = postDict["category"] as! String
                        let lat = postDict["lat"] as! Float
                        let lon = postDict["lng"] as! Float
                        let place = Place(name: name, address: address, reference: photo_reference, place_id: id, rating: rating, lat: lat, long: lon, type: category)
                        self.userPlaces.append(place)
                    }
                    
                }
                
            }
            self.tableView.reloadData()
            completed()
        })
        
    }


}

extension SpotsListVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            userLatitude = location.coordinate.latitude
            userLongitude = location.coordinate.longitude
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if(status == CLAuthorizationStatus.denied) {
            showLocationDisabledPopUp()
        }
    }
    
    func showLocationDisabledPopUp() {
        let alertController = UIAlertController(title: "Background Location Access Disabled",
                                                message: "In order to deliver pizza we need your location",
                                                preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let openAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
            if let url = URL(string: UIApplicationOpenSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        alertController.addAction(openAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
}

extension SpotsListVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userPlaces.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "placeCell", for: indexPath) as? placeCell {
            let place = userPlaces[indexPath.row]
            cell.configureCell(place: place, userLocation: ["lat": Float(userLatitude), "lon": Float(userLongitude)])
            return cell
        } else {
            return placeCell()
        }
    }
    
}
