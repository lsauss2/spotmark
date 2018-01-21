//
//  Place.swift
//  SpotMark
//
//  Created by Ludovic Saussinan on 21/1/18.
//  Copyright © 2018 Ludovic Saussinan. All rights reserved.
//

import Foundation

class Place {
    
    private var _placeId:String!
    private var _placeName:String!
    private var _placeRating:Double!
    private var _placeAddress:String!
    private var _placePhotoReference:String!
    private var _placeLatitude:Float!
    private var _placeLongitude:Float!
    private var _placeDetailsUrl:String!
    private var _placeOtherPhotos:[String] = []
    private var _placeReviews:[Dictionary<String, Any>] = []
    
    var placeId:String {
        if _placeId == nil {
            _placeId = ""
        }
        return _placeId
    }
    
    var placeName:String {
        if _placeName == nil {
            _placeName = ""
        }
        return _placeName
    }
    
    var placeRating:Double {
        if _placeRating == nil {
            _placeRating = 0.0
        }
        return _placeRating
    }
    
    var placeAddress:String {
        if _placeAddress == nil {
            _placeAddress = ""
        }
        return _placeAddress
    }
    
    var placePhotoReference:String {
        if _placePhotoReference == nil {
            _placePhotoReference = ""
        }
        return _placePhotoReference
    }
    
    var placeLatitude:Float {
        if _placeLatitude == nil {
            _placeLatitude = 0.0
        }
        return _placeLatitude
    }
    
    var placeLongitude:Float {
        if _placeLongitude == nil {
            _placeLongitude = 0.0
        }
        return _placeLongitude
    }
    
    var placeDetailsUrl:String {
        if _placeDetailsUrl == nil {
            _placeDetailsUrl = ""
        }
        return _placeDetailsUrl
    }
    
    var placeOtherPhotos:[String] {
        if _placeOtherPhotos == nil {
            _placeOtherPhotos = []
        }
        return _placeOtherPhotos
    }
    
    var placeReviews:[Dictionary<String, Any>] {
        if _placeReviews == nil {
            _placeReviews = []
        }
        return _placeReviews
    }
    
    init(name:String, address: String, reference: String, place_id: String, rating: Double, lat: Float, long: Float){
        self._placeName = name
        self._placeAddress = address
        self._placePhotoReference = reference
        self._placeId = place_id
        self._placeRating = rating
        self._placeLatitude = lat
        self._placeLongitude = long
        
        let placeDetailsUrl = "\(base_details_url)key=\(api_key)&placeid=\(place_id)"
        self._placeDetailsUrl = placeDetailsUrl
    }
    
    
}
