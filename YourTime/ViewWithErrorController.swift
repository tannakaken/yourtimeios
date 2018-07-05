//
//  ViewWithErrorController.swift
//  YourTime
//
//  Created by Kensaku Tanaka on 2018/07/05.
//  Copyright © 2018年 Kensaku Tanaka. All rights reserved.
//

import UIKit

class ViewWithErrorController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let error_message = ClockList.error_message {
            print(error_message)
            let alert = UIAlertController(title: "エラー", message: error_message, preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default)
            alert.addAction(ok)
            self.present(alert, animated: true)
            ClockList.error_message = nil
        }
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
