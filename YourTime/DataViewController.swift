//
//  DataViewController.swift
//  YourTime
//
//  Created by Kensaku Tanaka on 2018/05/07.
//  Copyright © 2018年 Kensaku Tanaka. All rights reserved.
//

import UIKit

class DataViewController: UIViewController {

    @IBOutlet weak var canvasView: CanvasView!
    @IBOutlet weak var dataLabel: UILabel!
    var dataObject: String = ""


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
        self.dataLabel!.text = dataObject
        self.animation()
    }
    
    func animation() {
        UIView.animate(withDuration: 100, animations: {
            self.canvasView.angle += 1
            self.canvasView.setNeedsDisplay()
        }, completion: {finished in
            self.animation()
        })
    }


}

