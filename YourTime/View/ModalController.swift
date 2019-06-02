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
    @IBOutlet weak var profileLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        popup.layer.cornerRadius = popup.frame.size.width * 0.05
        profileLabel.attributedText = attributedProfile()
    }
    
    private func attributedProfile() -> NSAttributedString {
        let profile = NSLocalizedString("profile", comment: "")
        let lines = profile.components(separatedBy: "\n")
        let authorAttributes:[NSAttributedString.Key : Any] = [
            .font : UIFont.systemFont(ofSize: 17.0)
        ]
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.headIndent = 10
        paragraphStyle.firstLineHeadIndent = 10
        let profileAttributes:[NSAttributedString.Key : Any] = [
            .font : UIFont.systemFont(ofSize: 14.0),
            .paragraphStyle : paragraphStyle
        ]
        let attributedText = NSMutableAttributedString(string: lines[0] + "\n", attributes: authorAttributes)
        for line in lines[1...] {
            let attributedLine = NSAttributedString(string: line + "\n", attributes: profileAttributes)
            attributedText.append(attributedLine)
        }
        return attributedText
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
