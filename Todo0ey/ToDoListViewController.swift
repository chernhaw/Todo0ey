//
//  ViewController.swift
//  Todo0ey
//
//  Created by tong chern haw on 9/1/19.
//  Copyright © 2019 tong chern haw. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray = ["Sleep well", "Eat Breakfast", "Read Bible"]
 
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO: Set yourself as the delegate and datasource here:
        itemArray = defaults.array(forKey: "TodoListArray") as! [String]
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itemArray.count
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell")
            else {
                fatalError("Could not dequeue a cell")
        }
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item
        
        return cell
    }
    
    
    //MARK - Tableview delegate method for selected row
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // print(itemArray[indexPath.row])

        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - add new items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
       var textField = UITextField()
        let alert = UIAlertController(title: "Add new Todo0ey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default)  {(action) in
            print("Success!")
            self.itemArray.append(textField.text!)
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            self.tableView.reloadData()
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new items"
           // print( alertTextField.text)
            textField = alertTextField
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
       // tableView.reloadData()
    }
}

