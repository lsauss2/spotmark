//
//  AddPlaceVC.swift
//  SpotMark
//
//  Created by Ludovic Saussinan on 21/1/18.
//  Copyright © 2018 Ludovic Saussinan. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class AddPlaceVC: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyLabel: UIStackView!
    
    
    let locationManager = CLLocationManager()
    var userLatitude = CLLocationDegrees()
    var userLongitude = CLLocationDegrees()
    var places = [Place]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            userLatitude = locationManager.location!.coordinate.latitude
            userLongitude = locationManager.location!.coordinate.longitude
        }
        
        self.downloadPlaces {
            
        }

        // Do any additional setup after loading the view.
    }
    
    @IBAction func closeBtnTapped(_ sender: Any) {
        view.endEditing(true)
        dismiss(animated: true, completion: nil)
    }
    
    func downloadPlaces(completed: @escaping DownloadComplete){
        places.removeAll()
        
        let search_url = "\(base_nearby_search_url)key=\(api_key)&location=\(userLatitude),\(userLongitude)&radius=500&rankby=prominence"
        print(search_url)
        
        var url = URL(string: search_url)
        
        Alamofire.request(url!).responseJSON { (response) in
            
            let result = response.result
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let placesResult = dict["results"] as? [Dictionary<String, AnyObject>] {
                    
                    for obj in placesResult {
                        
                        var name = ""
                        var address = ""
                        var placeId = ""
                        
                        if let placeName = obj["name"] as? String {
                            name = placeName
                        }
                        
                        if let placeAddress = obj["vicinity"] as? String {
                            address = placeAddress
                        }
                        
                        if let finalPlaceId = obj["place_id"] as? String {
                            placeId = finalPlaceId
                        }
                        
                        let place = Place(name: name, address: address, reference: "", place_id: placeId, rating: 0.0, lat: 0.0, long: 0.0)
                        
                        self.places.append(place)
                        
                    }
                    
                    self.tableView.reloadData()
                    
                }
                
            }
         
            completed()
        }
    }
    
    func getPlaceFromSearch(input:String, completed: @escaping DownloadComplete){
        
        places.removeAll()
        
        let url = "\(autocomplete_url)key=\(api_key)&input=\(input)&location=\(userLatitude),\(userLongitude)&radius=500"
        
        let forecastUrl = URL(string: url)
        Alamofire.request(forecastUrl!).responseJSON {response in
            
            let result = response.result
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if dict["status"] as? String == "OK" {
                if let placesResult = dict["predictions"] as? [Dictionary<String, AnyObject>] {
                    
                    for obj in placesResult {
                        
                        var name = ""
                        var address = ""
                        var placeId = ""
                        
                        if let finalPlaceId = obj["place_id"] as? String {
                            placeId = finalPlaceId
                        }
                        
                        if let placesData = obj["structured_formatting"] as? Dictionary<String, AnyObject> {
                            
                            if let placeName = placesData["main_text"] as? String {
                                name = placeName
                            }
                            
                            if let placeAddress = placesData["secondary_text"] as? String {
                                address = placeAddress
                            }
                            
                        }
                        
                        let place = Place(name: name, address: address, reference: "", place_id: placeId, rating: 0, lat: 0, long: 0)
                        
                        
                        self.places.append(place)
                        
                    }
                    self.tableView.isHidden = false
                    self.emptyLabel.isHidden = true
                    self.tableView.reloadData()
                    
                }
                } else {
                    self.tableView.isHidden = true
                    self.emptyLabel.isHidden = false
                }
                
            }
            
            completed()
        }
    }
    
}

extension AddPlaceVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as? searchPlaceCell {
            let place = places[indexPath.row]
            cell.configureCell(place: place)
            return cell
        } else {
            return searchPlaceCell()
        }
        
    }
    
}

extension AddPlaceVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            let newSearchString = searchText.replacingOccurrences(of: " ", with: "%20")
            self.getPlaceFromSearch(input: newSearchString, completed: {
                
            })
        } else {
            self.downloadPlaces {
                
            }
            
        }
    }
    
}

extension AddPlaceVC: CLLocationManagerDelegate {
    
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
