//
//  ConfDataViewController.swift
//  YourTime
//
//  Created by Kensaku Tanaka on 2018/07/01.
//  Copyright © 2018年 Kensaku Tanaka. All rights reserved.
//

import UIKit

class ConfDataViewController: UIViewController {
    var index : Int = NSNotFound

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var ampmField: UISegmentedControl!
    @IBOutlet weak var hoursField: UITextField!
    @IBOutlet weak var minutesField: UITextField!
    @IBOutlet weak var secondsField: UITextField!
    @IBOutlet weak var dialFromOneField: UISegmentedControl!
    @IBOutlet weak var clockwiseField: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ClockList.index = self.index
        nameField.text = ClockList.clock(at: self.index).name
        ampmField.selectedSegmentIndex = ClockList.clock(at: self.index).ampm.rawValue
        hoursField.text = String(ClockList.clock(at: self.index).hours)
        minutesField.text = String(ClockList.clock(at: self.index).minutes)
        secondsField.text = String(ClockList.clock(at: self.index).seconds)
        dialFromOneField.selectedSegmentIndex = ClockList.clock(at: self.index).dialFromOne ? 1 : 0
        clockwiseField.selectedSegmentIndex = ClockList.clock(at: self.index).clockwise ? 1 : 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nameChamged(_ sender: UITextField) {
        let newClock = Clock(name: sender.text!,
                             ampm: ClockList.clock(at: self.index).ampm,
                             hours: ClockList.clock(at: self.index).hours,
                             minutes: ClockList.clock(at: self.index).minutes,
                             seconds: ClockList.clock(at: self.index).seconds,
                             dialFromOne: ClockList.clock(at: self.index).dialFromOne,
                             clockwise: ClockList.clock(at: self.index).clockwise)
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
