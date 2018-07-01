//
//  ConfDataViewController.swift
//  YourTime
//
//  Created by Kensaku Tanaka on 2018/07/01.
//  Copyright © 2018年 Kensaku Tanaka. All rights reserved.
//

import UIKit

class ConfDataViewController: UIViewController {
    var dataObject: Clock = Clock.defaultClock()
    var index : Int = 0

    @IBOutlet weak var nameField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ClockList.index = self.index
        nameField.text = dataObject.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nameChamged(_ sender: UITextField) {
        let newClock = Clock(name: sender.text!,
                             ampm: self.dataObject.ampm,
                             hours: self.dataObject.hours,
                             minutes: self.dataObject.minutes,
                             seconds: self.dataObject.seconds,
                             dialFromOne: self.dataObject.dialFromOne,
                             clockwise: self.dataObject.clockwise)
        ClockList.set(clock: newClock, at: self.index)
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
