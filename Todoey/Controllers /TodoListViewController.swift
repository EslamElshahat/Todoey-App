//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    
    //    var _itemArray = ["Find Mike" , "Buy Eggs" , "Destroy Demon","jjk","Find Mike" , "Buy Eggs" , "Destroy Demon","jjk","Find Mike" , "Buy Eggs" , "Destroy Demon","jjk"]
    var itemArray = [Item]()
    var selectedCategory: Category? {
        didSet{
            loadItems()
        }
    }
    
    //    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    let context = (UIApplication.shared.delegate as! AppDelegate    ).persistentContainer.viewContext
    
    //    let defaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //                print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        
        loadItems()
        //                if let items = defaults.stringArray(forKey: "TodoListArray") as? [Item]{
        //                    itemArray = items
        //                }
    }
    
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {
        
//        print("\(selectedCategory?.name)")
        
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory?.name as! CVarArg)
        
        if let addtionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, addtionalPredicate])
        } else {
            request.predicate = categoryPredicate
        }
        
        
        do {
            itemArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        
        
        tableView.reloadData()
        
    }
    
    func saveItems(){
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        context.delete(itemArray[indexPath.row])
        itemArray.remove(at: indexPath.row)
        self.saveItems()
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        //        let itemTitle  = item.done ? "*" + (item.title)!  + "*" : item.title
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = (item.color)!  + " - " + (item.date)!
        //        cell.textLabel?.text = item.color
        cell.accessoryType = item.done ? .checkmark : .none
        //        if item.done == true {
        //            cell.accessoryType = .checkmark
        //        }else{
        //            cell.accessoryType = .none
        //        }
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
        //        performSegue(withIdentifier: "Edit", sender: self)
        
        //        self.navigationController?.popViewController(animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let edit = UIContextualAction(style: .normal, title:  "Edit", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            
            
            //            let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
            let item = self.itemArray[indexPath.row]
            
            let vc =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EditItemViewController") as? EditItemViewController
            vc?.iName = item.title!
            vc?.color = item.color!
            vc?.dName = item.date!
            vc?.cName = item.parentCategory?.name!
            self.navigationController?.pushViewController(vc!, animated: true)
            //            let next = self.storyboard?.instantiateViewController(withIdentifier: "EditItemViewController") as! EditItemViewController
            //            self.present(next,animated: true,completion: nil)
            
            //            let vc2 =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreateItemViewController") as? CreateItemViewController
            ////            vc?.isUpdated = false
            //            self.navigationController?.pushViewController(vc2!, animated: true)
            
            //            self.performSegue(withIdentifier: "Edit", sender: self)
            
            
            //            vc?.isUpdated = true
            //
            //
            //            vc?.iName = item.title!
            //            vc?.color = item.color!
            //            vc?.dName = item.date!
            //            vc?.cName = item.parentCategory?.name!
            //            self.saveItems()
            
            //            self.navigationController?.pushViewController(vc!, animated: true)
            
        })
        return UISwipeActionsConfiguration(actions: [edit])
        
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        //        var textField = UITextField()
        //        let alert = UIAlertController(title: "Add New Todo Item", message: "", preferredStyle: .alert)
        //        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
        //
        //            let newItem = Item(context: self.context)
        //            newItem.title = textField.text!
        //            newItem.done = false
        //            newItem.parentCategory = self.selectedCategory
        //            self.itemArray.append(newItem)
        //
        //            self.saveItems()
        //            //            print(self.itemArray)
        //            //            self.defaults.set(self.itemArray, forKey: "TodoListArray")
        //
        //        }
        //        alert.addTextField { (alertTextField) in
        //            alertTextField.placeholder = "Create New Item"
        //            textField = alertTextField
        //            //            print(alertTextField.text)
        //        }
        //        alert.addAction(action)
        //        present(alert, animated: true, completion: nil)
        
        //        performSegue(withIdentifier: "createItem", sender: self)
        
        let vc =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreateItemViewController") as? CreateItemViewController
        vc?.isUpdated = false
        self.navigationController?.pushViewController(vc!, animated: true)
        
        
    }
    
    
}

extension TodoListViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        loadItems(with: request , predicate: predicate)
        //        do{
        //            itemArray = try context.fetch(request)
        //        }catch{
        //            print("Error")
        //        }
        //        tableView.reloadData()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0{
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }else{
            let request: NSFetchRequest<Item> = Item.fetchRequest()
            request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
            request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
            loadItems(with: request)
        }
    }
}
extension String {
    func strikeThrough() -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(
            NSAttributedString.Key.strikethroughStyle,
            value: NSUnderlineStyle.single.rawValue,
            range:NSMakeRange(0,attributeString.length))
        return attributeString
    }
}
