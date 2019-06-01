//
//  PopUpController.swift
//  YourTime
//
//  Created by Kensaku Tanaka on 2018/07/05.
//  Copyright © 2018年 Kensaku Tanaka. All rights reserved.
//

import UIKit

class ModalController: UIViewController {
    
    @IBOutlet weak var popup: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        popup.layer.cornerRadius = popup.frame.size.width * 0.05
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        for touch: UITouch in touches {
            if let view = touch.view {
                let tag = view.tag
                if tag == 1 {
                    dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func tapMail(_ sender: Any) {
        UIApplication.shared.open(URL(string: "mailto:tannakaken@gmail.com")!, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
    }
    
    @IBAction func tapWebPage(_ sender: Any) {
        UIApplication.shared.open(URL(string: "https://tannakaken.xyz")!, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
        
    }
    
    @IBAction func tapNovel(_ sender: Any) {
        UIApplication.shared.open(URL(string: "https://tannakaken.xyz/novels/YourTime")!, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}
