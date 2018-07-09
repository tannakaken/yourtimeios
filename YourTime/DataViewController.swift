//
//  DataViewController.swift
//  YourTime
//
//  Created by Kensaku Tanaka on 2018/05/07.
//  Copyright © 2018年 Kensaku Tanaka. All rights reserved.
//

import UIKit

class DataViewController: ViewWithBannerAdController {
    
    @IBOutlet weak var easterEggLabel: UILabel!
    @IBOutlet var doubleTapRecognizer: UITapGestureRecognizer!
    
    @IBOutlet weak var clockName: UINavigationItem!
    @IBOutlet weak var canvasView: CanvasView!
    var dataObject: Clock = Clock.defaultClock()
    var index : Int = 0
    
    static func getColor() -> UIColor {
        if UserDefaults.standard.bool(forKey: "blackBackground") {
            return .black
        } else {
            return .white
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let backgroundColor = DataViewController.getColor()
        self.canvasView.backgroundColor = backgroundColor
        self.canvasView.foregroundColor = backgroundColor == .black ? .white : .black
        self.clockName.title = self.dataObject.name
        ClockList.index = self.index
        self.canvasView.clock = self.dataObject
        self.animation()
    }
    
    func animation() {
        UIView.animate(withDuration: 0.5, animations: {
            let now = Date()
            let millisecond = now.millisecond()
            self.canvasView.ticktack(millisecond: millisecond)
            self.canvasView.setNeedsDisplay()
        }, completion: {finished in
            self.animation()
        })
    }
    
    @IBAction func tapQuestion(_ sender: Any) {
        if let storyboard = self.storyboard {
            let next = storyboard.instantiateViewController(withIdentifier: "Modal")
            next.modalPresentationStyle = .overCurrentContext
            present(next, animated: true)
        }
    }
    @IBAction func tapExclamation(_ sender: Any) {
        if self.canvasView.backgroundColor == .black {
            self.canvasView.backgroundColor = .white
            self.canvasView.foregroundColor = .black
            UserDefaults.standard.set(false, forKey: "blackBackground")
        } else {
            self.canvasView.backgroundColor = .black
            self.canvasView.foregroundColor = .white
            UserDefaults.standard.set(true, forKey: "blackBackground")
        }
    }
    
    let randomMessage = [
        "夏への扉",
        "輪廻の蛇",
        "笹の葉ラプソディ",
        "タイムマシン"
    ]
    
    @IBAction func doubleTapCanvas(_ sender: Any) {
        self.easterEggLabel.text = randomMessage[Int(arc4random_uniform(3))]
        doubleTapRecognizer.isEnabled = false
        UIView.animate(withDuration: 1.0,
                       delay: 0.0,
                       options: [.curveEaseIn],
                       animations: {self.easterEggLabel.alpha = 1.0},
                       completion: {_ in
                        UIView.animate(withDuration: 1.0,
                                       delay: 0.0,
                                       options: [.curveEaseIn],
                                       animations: {self.easterEggLabel.alpha = 0.0},
                                       completion: {_ in self.doubleTapRecognizer.isEnabled = true})
        })
    }
    
}

