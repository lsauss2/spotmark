//
//  WalkthroughVC.swift
//  SpotMark
//
//  Created by Ludovic Saussinan on 21/1/18.
//  Copyright © 2018 Ludovic Saussinan. All rights reserved.
//

import UIKit

class WalkthroughVC: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    let feature1 = ["title": "Header number one", "description": "Description number one", "image": "walkthrough-one"]
    let feature2 = ["title": "Header number two", "description": "Description number two", "image": "walkthrough-two"]
    let feature3 = ["title": "Header number three", "description": "Description number three", "image": "walkthrough-three"]
    
    var featureArray = [Dictionary<String, String>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        
        featureArray = [feature1, feature2, feature3]
        scrollView.isPagingEnabled = true
        scrollView.contentSize = CGSize(width: self.view.bounds.width * 3, height: 500)
        scrollView.showsHorizontalScrollIndicator = false
        
        loadFeatures()
        
    }
    
    func loadFeatures() {
        
        for (index, feature) in featureArray.enumerated() {
            if let featureView = Bundle.main.loadNibNamed("WalkthroughView", owner: self, options: nil)?.first as? WalkthroughView {
                
                featureView.walktrhroughImage.image = UIImage(named: feature["image"]!)
                featureView.walkthroughHeader.text = feature["title"]
                featureView.walkthroughDetails.text = feature["description"]
                
                scrollView.addSubview(featureView)
                featureView.frame.size.width = self.view.bounds.size.width
                featureView.frame.origin.x = CGFloat(index) * self.view.bounds.size.width
                
            }
            
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let page = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControl.currentPage = Int(page)
        
    }

}
