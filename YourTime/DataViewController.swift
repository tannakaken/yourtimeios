//
//  DataViewController.swift
//  YourTime
//
//  Created by Kensaku Tanaka on 2018/05/07.
//  Copyright © 2018年 Kensaku Tanaka. All rights reserved.
//

import UIKit

class DataViewController: UIViewController {

    
    @IBOutlet weak var clockName: UINavigationItem!
    @IBOutlet weak var canvasView: CanvasView!
    var dataObject: Clock = Clock.defaultClock()
    var index : Int = 0


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
        self.clockName.title = self.dataObject.name
        ClockList.index = self.index
        self.canvasView.clock = self.dataObject
        self.animation()
    }
    
    func animation() {
        UIView.animate(withDuration: 100, animations: {
            let now = Date()
            let millisecond = now.millisecond()
            self.canvasView.ticktack(millisecond: millisecond)
            self.canvasView.setNeedsDisplay()
        }, completion: {finished in
            self.animation()
        })
    }

}

