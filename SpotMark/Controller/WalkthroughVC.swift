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
    
    let feature1 = ["title": "Discover places around", "description": "Go out there and discover new places that you want to try", "image": "walkthrough-one"]
    let feature2 = ["title": "Save your favorites spots", "description": "Like a place? Save it in Spotmark to have it always at hand", "image": "walkthrough-two"]
    let feature3 = ["title": "Always know where to go", "description": "With all your favorite places at hand, always know where to go", "image": "walkthrough-three"]
    
    var featureArray = [Dictionary<String, String>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        
        featureArray = [feature1, feature2, feature3]
        scrollView.isPagingEnabled = true
        scrollView.contentSize = CGSize(width: self.view.bounds.width * 3, height: 570)
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
    
    @IBAction func getStartedBtnTapped(_ sender: Any) {
        performSegue(withIdentifier: "showHomeFromWalkthrough", sender: nil)
    }
    
    

}
