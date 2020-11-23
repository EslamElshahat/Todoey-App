//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Eslam Elshaht on 11/21/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {
    
    
    var categories = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
        
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        context.delete(categories[indexPath.row])
        categories.remove(at: indexPath.row)
        saveCategories()
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let item = categories[indexPath.row]
        cell.textLabel?.text = item.name
        //        cell.accessoryType = item.done ? .checkmark : .none
        return cell
        
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TodoListViewController") as? TodoListViewController
        //        self.navigationController?.pushViewController(vc!, animated: true)
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todo Catogery", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Catogery", style: .default) { (action) in
            
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            //            newItem.done = false
            self.categories.append(newCategory)
            
            self.saveCategories()
            //            print(self.itemArray)
            //            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Category"
            textField = alertTextField
            //            print(alertTextField.text)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    func saveCategories(){
        //        let encoder  = PropertyListEncoder()
        do{
            try context.save()
            
            //            let data = try encoder.encode(itemArray)
            //            try data.write(to: dataFilePath!)
        }catch{
            
            print("Error")
        }
        self.tableView.reloadData()
    }
    func loadCategories() {
        
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        
        do{
            categories = try context.fetch(request)
        } catch {
            print("Error loading categories \(error)")
        }
        
        tableView.reloadData()
        
    }
}
