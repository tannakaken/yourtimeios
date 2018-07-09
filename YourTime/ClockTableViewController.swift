//
//  ClockTableViewController.swift
//  YourTime
//
//  Created by Kensaku Tanaka on 2018/07/02.
//  Copyright © 2018年 Kensaku Tanaka. All rights reserved.
//

import UIKit
import WatchConnectivity

class ClockTableViewController: UITableViewController {

    
    @IBOutlet weak var navigation: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        navigation.leftBarButtonItem = self.editButtonItem
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
        // Configure the cell...
        cell.textLabel?.text = ClockList.clock(at: indexPath.row).name
        let button = UIButton(frame: CGRect(x: tableView.frame.width - 40, y: cell.center.y - 15, width: 40, height: 30))
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
        ClockList.append(Clock.defaultClock())
        tableView.insertRows(at: [IndexPath(row: ClockList.count()-1, section: 0)], with: .fade)
        tableView.reloadData()
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if ClockList.count() > 1 {
                let session = WCSession.default
                session.transferUserInfo(["remove":indexPath.row])
                let _ = ClockList.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            } else {
                let error_message = "時間がなくなってしまいます！"
                let alert = UIAlertController(title: "エラー", message: error_message, preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default)
                alert.addAction(ok)
                self.present(alert, animated: true)
            }
        } else if editingStyle == .insert {
            ClockList.insert(Clock.defaultClock(), at: indexPath.row)
            tableView.insertRows(at: [indexPath], with: .fade)
        }
        tableView.reloadData()
    }

    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let session = WCSession.default
        session.transferUserInfo(["from":fromIndexPath.row, "to":to.row])
        if (fromIndexPath.row != to.row) {
            let clock = ClockList.remove(at: fromIndexPath.row)
            ClockList.insert(clock, at: to.row)
            tableView.reloadData()
        }
    }

    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
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
