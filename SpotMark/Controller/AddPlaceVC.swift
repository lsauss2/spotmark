//
//  AddPlaceVC.swift
//  SpotMark
//
//  Created by Ludovic Saussinan on 21/1/18.
//  Copyright © 2018 Ludovic Saussinan. All rights reserved.
//

import UIKit
import Alamofire

class AddPlaceVC: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var places = [Place]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
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
        
        var url = URL(string: test_url)
        
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
        
        let forecastUrl = URL(string: "https://maps.googleapis.com/maps/api/place/autocomplete/json?key=AIzaSyDDzFcsajCTfbIGYMCZwKKGu8y1IPk9GyE&input=\(input)&types=establishment&location=41.390205,2.154007&radius=500")
        Alamofire.request(forecastUrl!).responseJSON {response in
            
            let result = response.result
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
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
                    
                    self.tableView.reloadData()
                    
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
