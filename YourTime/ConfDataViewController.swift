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
    @IBOutlet weak var hoursPicker: UIPickerView!
    @IBOutlet weak var minutesPicker: UIPickerView!
    @IBOutlet weak var secondsPicker: UIPickerView!
    @IBOutlet weak var dialFromOneField: UISegmentedControl!
    @IBOutlet weak var clockwiseField: UISegmentedControl!
    
    class PickerController: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
        var data : [Int]
        var index: Int
        init(data: [Int], index: Int) {
            self.data = data
            self.index = index
        }
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return self.data.count
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return String(self.data[row])
        }
    }
    
    class HoursPickerController: PickerController {
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            let newClock = Clock(name: ClockList.clock(at: index).name,
                                 ampm: ClockList.clock(at: index).ampm,
                                 hours: self.data[row],
                                 minutes: ClockList.clock(at: index).minutes,
                                 seconds: ClockList.clock(at: index).seconds,
                                 dialFromOne: ClockList.clock(at: index).dialFromOne,
                                 clockwise: ClockList.clock(at: index).clockwise)
            ClockList.set(clock: newClock, at: index)
        }
    }
    
    class MinutesPickerController: PickerController {
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            let newClock = Clock(name: ClockList.clock(at: index).name,
                                 ampm: ClockList.clock(at: index).ampm,
                                 hours: ClockList.clock(at: index).hours,
                                 minutes: self.data[row],
                                 seconds: ClockList.clock(at: index).seconds,
                                 dialFromOne: ClockList.clock(at: index).dialFromOne,
                                 clockwise: ClockList.clock(at: index).clockwise)
            ClockList.set(clock: newClock, at: index)
        }
    }
    
    class SecondsPickerController: PickerController {
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            let newClock = Clock(name: ClockList.clock(at: index).name,
                                 ampm: ClockList.clock(at: index).ampm,
                                 hours: ClockList.clock(at: index).hours,
                                 minutes: ClockList.clock(at: index).minutes,
                                 seconds: self.data[row],
                                 dialFromOne: ClockList.clock(at: index).dialFromOne,
                                 clockwise: ClockList.clock(at: index).clockwise)
            ClockList.set(clock: newClock, at: index)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let hoursPickerController = HoursPickerController(data: (Array<Int>)(1...20), index:index)
        hoursPicker.delegate = hoursPickerController
        hoursPicker.dataSource = hoursPickerController
        let minutesPickerController = MinutesPickerController(data: (Array<Int>)(1...100), index:index)
        minutesPicker.delegate = minutesPickerController
        minutesPicker.dataSource = minutesPickerController
        let secondsPickerController = SecondsPickerController(data: (Array<Int>)(1...100), index:index)
        secondsPicker.delegate = secondsPickerController
        secondsPicker.dataSource = secondsPickerController
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ClockList.index = self.index
        nameField.text = ClockList.clock(at: self.index).name
        ampmField.selectedSegmentIndex = ClockList.clock(at: self.index).ampm.rawValue
        
        dialFromOneField.selectedSegmentIndex = ClockList.clock(at: self.index).dialFromOne ? 1 : 0
        clockwiseField.selectedSegmentIndex = ClockList.clock(at: self.index).clockwise ? 1 : 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    @IBAction func nameChanged(_ sender: UITextField) {
        let newClock = Clock(name: sender.text!,
                             ampm: ClockList.clock(at: self.index).ampm,
                             hours: ClockList.clock(at: self.index).hours,
                             minutes: ClockList.clock(at: self.index).minutes,
                             seconds: ClockList.clock(at: self.index).seconds,
                             dialFromOne: ClockList.clock(at: self.index).dialFromOne,
                             clockwise: ClockList.clock(at: self.index).clockwise)
        ClockList.set(clock: newClock, at: self.index)
    }
    
    @IBAction func ampmChanged(_ sender: UISegmentedControl) {
        let newClock = Clock(name: ClockList.clock(at: self.index).name,
                             ampm: Ampm(rawValue: sender.selectedSegmentIndex)!,
                             hours: ClockList.clock(at: self.index).hours,
                             minutes: ClockList.clock(at: self.index).minutes,
                             seconds: ClockList.clock(at: self.index).seconds,
                             dialFromOne: ClockList.clock(at: self.index).dialFromOne,
                             clockwise: ClockList.clock(at: self.index).clockwise)
        ClockList.set(clock: newClock, at: self.index)
    }
    

    
    @IBAction func dialFromOneChanged(_ sender: UISegmentedControl) {
        let newClock = Clock(name: ClockList.clock(at: self.index).name,
                             ampm: ClockList.clock(at: self.index).ampm,
                             hours: ClockList.clock(at: self.index).hours,
                             minutes: ClockList.clock(at: self.index).minutes,
                             seconds: ClockList.clock(at: self.index).seconds,
                             dialFromOne: sender.selectedSegmentIndex == 1,
                             clockwise: ClockList.clock(at: self.index).clockwise)
        ClockList.set(clock: newClock, at: self.index)
    }
    
    @IBAction func clockwiseChanged(_ sender: UISegmentedControl) {
        let newClock = Clock(name: ClockList.clock(at: self.index).name,
                             ampm: ClockList.clock(at: self.index).ampm,
                             hours: ClockList.clock(at: self.index).hours,
                             minutes: ClockList.clock(at: self.index).minutes,
                             seconds: ClockList.clock(at: self.index).seconds,
                             dialFromOne: ClockList.clock(at: self.index).dialFromOne,
                             clockwise: sender.selectedSegmentIndex == 1)
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
