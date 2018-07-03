//
//  ClockTableViewController.swift
//  YourTime
//
//  Created by Kensaku Tanaka on 2018/07/02.
//  Copyright © 2018年 Kensaku Tanaka. All rights reserved.
//

import UIKit

class ClockTableViewController: UITableViewController {

    
    @IBOutlet weak var navigation: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        navigation.leftBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ClockList.count()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClockCell", for: indexPath)
        let width = cell.bounds.width
        // Configure the cell...
        cell.textLabel?.text = ClockList.clock(at: indexPath.row).name
        let button = UIButton(frame: CGRect(x: width - 55, y: 5, width: 50, height: 30))
        button.backgroundColor = .black
        button.setTitleColor(.white, for: [.normal])
        button.setTitle("設定", for: [.normal])
        button.tag = indexPath.row
        button.addTarget(self, action: #selector(tapButton(sender:)), for: .touchUpInside)
        cell.contentView.addSubview(button)

        return cell
    }
    
    @objc func tapButton(sender: UIButton) {
        ClockList.index = sender.tag
        performSegue(withIdentifier: "toConfView",sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ClockList.index = indexPath.row
        performSegue(withIdentifier: "toRootView",sender: nil)
    }
    
    @IBAction func addClock(_ sender: Any) {
        
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
