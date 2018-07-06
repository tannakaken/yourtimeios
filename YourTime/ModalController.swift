//
//  PopUpController.swift
//  YourTime
//
//  Created by Kensaku Tanaka on 2018/07/05.
//  Copyright © 2018年 Kensaku Tanaka. All rights reserved.
//

import UIKit

class ModalController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
        UIApplication.shared.open(URL(string: "mailto:tannakaken@gmail.com")!, options: [:], completionHandler: nil)
    }
    
    @IBAction func tapWebPage(_ sender: Any) {
        UIApplication.shared.open(URL(string: "https://tannakaken.xyz")!, options: [:], completionHandler: nil)
        
    }
    
    @IBAction func tapNovel(_ sender: Any) {
        UIApplication.shared.open(URL(string: "https://tannakaken.xyz/novels/YourTime")!, options: [:], completionHandler: nil)
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
