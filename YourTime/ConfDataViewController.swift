//
//  ConfDataViewController.swift
//  YourTime
//
//  Created by Kensaku Tanaka on 2018/07/01.
//  Copyright © 2018年 Kensaku Tanaka. All rights reserved.
//

import UIKit

class ConfDataViewController: ViewWithBannerAdController, UIPickerViewDelegate, UIPickerViewDataSource {
    var index : Int = NSNotFound

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var ampmField: UISegmentedControl!
    @IBOutlet weak var timePicker: UIPickerView!
    @IBOutlet weak var dialFromOneField: UISegmentedControl!
    @IBOutlet weak var clockwiseField: UISegmentedControl!
    
    let data : [[Int]] = [
        (Array<Int>)(1...100),
        (Array<Int>)(1...100),
        (Array<Int>)(1...100)
    ]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(data[component][row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let clock = ClockList.clock(at: self.index)
        let newClock = Clock(name: clock.name,
                             ampm: clock.ampm,
                             hours: component == 0 ? row + 1 : clock.hours,
                             minutes: component == 1 ? row + 1 : clock.minutes,
                             seconds: component == 2 ? row + 1 : clock.seconds,
                             dialFromOne: clock.dialFromOne,
                             clockwise: clock.clockwise)
        ClockList.set(clock: newClock, at: self.index)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timePicker.delegate = self
        timePicker.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ClockList.index = self.index
        let clock = ClockList.clock(at: self.index)
        nameField.text = clock.name
        ampmField.selectedSegmentIndex = clock.ampm.rawValue - 1
        timePicker.selectRow(clock.hours-1, inComponent: 0, animated: false)
        timePicker.selectRow(clock.minutes-1, inComponent: 1, animated: false)
        timePicker.selectRow(clock.seconds-1, inComponent: 2, animated: false)
        dialFromOneField.selectedSegmentIndex = clock.dialFromOne ? 1 : 0
        clockwiseField.selectedSegmentIndex = clock.clockwise ? 1 : 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    @IBAction func nameChanged(_ sender: UITextField) {
        let clock = ClockList.clock(at: self.index)
        if let name = sender.text {
            if name.contains("\n") || name.contains("¥t") {
                let error_message = "壊れた時間名のデータを修復します"
                sender.text = clock.name
                print(error_message)
                let alert = UIAlertController(title: "エラー", message: error_message, preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default)
                alert.addAction(ok)
                self.present(alert, animated: true)
                return
            }
            let newClock = Clock(name: name,
                                 ampm: clock.ampm,
                                 hours: clock.hours,
                                 minutes: clock.minutes,
                                 seconds: clock.seconds,
                                 dialFromOne: clock.dialFromOne,
                                 clockwise: clock.clockwise)
            ClockList.set(clock: newClock, at: self.index)
        } else {
            let error_message = "失われた時間名のデータを修復します"
            print(error_message)
            let alert = UIAlertController(title: "エラー", message: error_message, preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default)
            alert.addAction(ok)
            self.present(alert, animated: true)
            sender.text = ClockList.clock(at: self.index).name
        }
    }
    
    @IBAction func ampmChanged(_ sender: UISegmentedControl) {
        let clock = ClockList.clock(at: self.index)
        if let ampm = Ampm(rawValue: sender.selectedSegmentIndex+1) {
            let newClock = Clock(name: clock.name,
                                 ampm: ampm,
                                 hours: clock.hours,
                                 minutes: clock.minutes,
                                 seconds: clock.seconds,
                                 dialFromOne: clock.dialFromOne,
                                 clockwise: clock.clockwise)
            ClockList.set(clock: newClock, at: self.index)
        } else {
            let error_message = "壊れた午数のデータを修復します"
            print(error_message)
            let alert = UIAlertController(title: "エラー", message: error_message, preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default)
            alert.addAction(ok)
            self.present(alert, animated: true)
            sender.selectedSegmentIndex = ClockList.clock(at: self.index).ampm.rawValue - 1
        }
    }
    
    @IBAction func dialFromOneChanged(_ sender: UISegmentedControl) {
        let clock = ClockList.clock(at: self.index)
        let newClock = Clock(name: clock.name,
                             ampm: clock.ampm,
                             hours: clock.hours,
                             minutes: clock.minutes,
                             seconds: clock.seconds,
                             dialFromOne: sender.selectedSegmentIndex == 1,
                             clockwise: clock.clockwise)
        ClockList.set(clock: newClock, at: self.index)
    }
    
    @IBAction func clockwiseChanged(_ sender: UISegmentedControl) {
        let clock = ClockList.clock(at: self.index)
        let newClock = Clock(name: clock.name,
                             ampm: clock.ampm,
                             hours: clock.hours,
                             minutes: clock.minutes,
                             seconds: clock.seconds,
                             dialFromOne: clock.dialFromOne,
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
