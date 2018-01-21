//
//  Constants.swift
//  SpotMark
//
//  Created by Ludovic Saussinan on 21/1/18.
//  Copyright © 2018 Ludovic Saussinan. All rights reserved.
//

import Foundation

typealias DownloadComplete = () -> ()

let test_url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=AIzaSyDDzFcsajCTfbIGYMCZwKKGu8y1IPk9GyE&location=41.390205,2.154007&radius=500&types=bar"

let api_key = "AIzaSyDDzFcsajCTfbIGYMCZwKKGu8y1IPk9GyE"
let base_nearby_search_url:String = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?"
let base_text_search_url:String = "https://maps.googleapis.com/maps/api/place/textsearch/json?"
let base_details_url:String = "https://maps.googleapis.com/maps/api/place/details/json?"
let base_photos_url:String = "https://maps.googleapis.com/maps/api/place/photo?"
let autocomplete_url:String = "https://maps.googleapis.com/maps/api/place/autocomplete/json?"
