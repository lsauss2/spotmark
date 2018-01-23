//
//  ConfirmPlaceVC.swift
//  SpotMark
//
//  Created by Ludovic Saussinan on 22/1/18.
//  Copyright © 2018 Ludovic Saussinan. All rights reserved.
//

import UIKit
import Alamofire
import Firebase

class ConfirmPlaceVC: UIViewController {
    
    var place: Place!
    var currentPlace: Place?
    var category = ""
    
    @IBOutlet weak var placeImageHolder: roundedImage!
    @IBOutlet weak var placeAddresLbl: UILabel!
    @IBOutlet weak var placeNameLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadPlaceDetails {

        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func downloadPlaceDetails(completed: @escaping DownloadComplete){
        
        let detailsurl = "\(base_details_url)key=\(api_key)&placeid=\(place.placeId)"
        let url = URL(string: detailsurl)
        
        Alamofire.request(url!).responseJSON { (response) in
            
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let placeResult = dict["result"] as? Dictionary<String, AnyObject> {
                    
                    var name = ""
                    var address = ""
                    var lat: Float = 0.0
                    var lon: Float = 0.0
                    var rating = 0.0
                    var picture = ""
                    
                    if let placeName = placeResult["name"] as? String {
                        name = placeName
                    }
                    
                    if let placeAddress = placeResult["vicinity"] as? String {
                        address = placeAddress
                    }
                    
                    if let placeRating = placeResult["rating"] as? Double {
                        rating = placeRating
                    }
                    
                    if let placePhotos = placeResult["photos"] as? [Dictionary<String, AnyObject>] {
                        if let firstPhoto = placePhotos[0] as? Dictionary<String, AnyObject> {
                            if let photoReference = firstPhoto["photo_reference"] as? String {
                                picture = photoReference
                            }
                        }
                    }
                    
                    if let placeGeometry = placeResult["geometry"] as? Dictionary<String, AnyObject> {
                        if let placeLocation = placeGeometry["location"] as? Dictionary<String, AnyObject> {
                            if let placeLat = placeLocation["lat"] as? Float {
                                lat = placeLat
                            }
                            if let placeLon = placeLocation["lng"] as? Float {
                                lon = placeLon
                            }
                        }
                    }
                    
                    self.currentPlace = Place(name: name, address: address, reference: picture, place_id: self.place.placeId, rating: rating, lat: lat, long: lon)
                    
                    self.setupUI(place: self.currentPlace!)
                    
                    
                }
                
            }
           completed()
        }
        
    }
    
    @IBAction func addPlace(_ sender: Any) {
        if category != "" {
        let sv = displaySpinner(onView: self.view)
        let placeId = currentPlace?.placeId
        let placeData = ["name": currentPlace?.placeName, "address": currentPlace?.placeAddress, "photo": currentPlace?.placePhotoReference, "lat": currentPlace?.placeLatitude, "lng": currentPlace?.placeLongitude, "rating": currentPlace?.placeRating, "owner": Auth.auth().currentUser?.uid, "category": category] as Dictionary<String, Any>
            DataService.instance.createPlaceInDb(id: placeId!, placeData: placeData, placeCreationComplete: { (success, error) in
                if success {
                    print("Place Added")
                    self.removeSpinner(spinner: sv)
                    self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
                }
            })
        }
    }
    
    func setupUI(place: Place){
        placeAddresLbl.text = place.placeAddress
        placeNameLbl.text = place.placeName
        
        let placePhotoReference = place.placePhotoReference
        let photoUrl = "\(base_photos_url)key=\(api_key)&photoreference=\(placePhotoReference)&maxwidth=400"
        
        if let url = NSURL(string: photoUrl) {
            if let data = NSData(contentsOf: url as URL) {
                placeImageHolder.image = UIImage(data: data as Data)
            }
        }
    }
    
    @IBAction func categoryTapped(_ sender: CustomButton) {
        if sender.tag == 0 {
            let activeButton = view.viewWithTag(1) as? CustomButton
            if activeButton == nil {
                sender.tag = 1
                sender.backgroundColor = #colorLiteral(red: 0.6395461559, green: 0.6430392861, blue: 0.7407739162, alpha: 1)
                sender.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
            } else {
                activeButton?.backgroundColor = #colorLiteral(red: 0.9531012177, green: 0.9531235099, blue: 0.9531114697, alpha: 1)
                activeButton?.setTitleColor(#colorLiteral(red: 0.4352941176, green: 0.4431372549, blue: 0.4745098039, alpha: 1), for: .normal)
                activeButton?.tag = 0
                sender.tag = 1
                sender.backgroundColor = #colorLiteral(red: 0.6395461559, green: 0.6430392861, blue: 0.7407739162, alpha: 1)
                sender.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
            }
            category = sender.titleLabel!.text!
        } else {
        sender.tag = 0
        sender.backgroundColor = #colorLiteral(red: 0.9531012177, green: 0.9531235099, blue: 0.9531114697, alpha: 1)
        sender.setTitleColor(#colorLiteral(red: 0.4352941176, green: 0.4431372549, blue: 0.4745098039, alpha: 1), for: .normal)
        }
    }
    
    func displaySpinner(onView : UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        return spinnerView
    }
    
    func removeSpinner(spinner :UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
    
    
    

}
