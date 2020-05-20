//
//  ViewController.swift
//  ToDoApp
//
//  Created by Amanda Burger on 5/19/20.
//  Copyright © 2020 Amanda Burger. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UITableViewController {
    var itemArr: [String] = []

    
    @IBOutlet var tablView: UITableView!
    // View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    //Add Pressed
    @IBAction func addPressed(_ sender: Any) {
        var tf = UITextField()
        let alert = UIAlertController(title: "Add Item", message: "Add Item to the todo list?", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) { (action) in
            self.itemArr.append(tf.text!)
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTf) in
            alertTf.placeholder = "Create new To Do List item"
            tf = alertTf
        }
        alert.addAction(saveAction)
        present(alert, animated: true)
    }
    
    
//  MARK: - Table View Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = itemArr[indexPath.row]
        return cell
    }
    
}
