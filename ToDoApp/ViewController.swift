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
    var itemArr: [NSManagedObject] = []

//MARK: View Did Load
    @IBOutlet var tablView: UITableView!
    // View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
// MARK: View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Item")
        do {
          itemArr = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    

// MARK: Add Pressed
    @IBAction func addPressed(_ sender: Any) {
        var tf = UITextField()
        let alert = UIAlertController(title: "Add Item", message: "Add Item to the todo list?", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) { (action) in
            self.save(title: tf.text!)
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
        let toDoItem = itemArr[indexPath.row]
        let doneVal = itemArr[indexPath.row].value(forKey: "done") as? Bool
        if doneVal == nil{
            itemArr[indexPath.row].setValue(false, forKey: "done")
        }
        cell.textLabel?.text = toDoItem.value(forKey: "title") as? String
        if doneVal == true{
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    
// MARK: -SaveData Function
    func save(title: String){
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Item", in: managedContext)!
        let item = NSManagedObject(entity: entity, insertInto: managedContext)
        item.setValue(title, forKeyPath: "title")
        item.setValue(false, forKey: "done")

        do {
            try managedContext.save()
            itemArr.append(item)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
// MARK: SelectRow
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var doneVal = itemArr[indexPath.row].value(forKey: "done") as? Bool
        if doneVal ==  nil{
            doneVal = false
        }
        if doneVal == true{
            itemArr[indexPath.row].setValue(false, forKey: "done")
        }else{
            itemArr[indexPath.row].setValue(true, forKey: "done")
        }
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
    }
        
}
