//
//  ViewWithBannerAdController.swift
//  YourTime
//
//  Created by Kensaku Tanaka on 2018/07/04.
//  Copyright © 2018年 Kensaku Tanaka. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ViewWithBannerAdController: UIViewController {
    
    var bannerView: GADBannerView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        addBannerViewToView(bannerView)
        bannerView.adUnitID = "ca-app-pub-2965415045499808/6522776016"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        NSLayoutConstraint.activate(
            [
                NSLayoutConstraint(item: bannerView,
                                   attribute: .bottom,
                                   relatedBy: .equal,
                                   toItem: view.safeAreaLayoutGuide,
                                   attribute: .bottom,
                                   multiplier: 1,
                                   constant: 0),
                NSLayoutConstraint(item: bannerView,
                                   attribute: .centerX,
                                   relatedBy: .equal,
                                   toItem: view,
                                   attribute: .centerX,
                                   multiplier: 1,
                                   constant: 0)
            ]
        )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
