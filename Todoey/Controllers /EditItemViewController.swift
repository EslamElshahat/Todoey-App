//
//  EditItemViewController.swift
//  Todoey
//
//  Created by Eslam Elshaht on 12/14/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class EditItemViewController: UIViewController,UITextFieldDelegate{
    
    var iName: String?
    var cName: String?
    var dName: String?
    var color: String?
    
    @IBOutlet weak var itemName: UITextField!
    @IBOutlet weak var CategoryName: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var Red: UIButton!
    @IBOutlet weak var Green: UIButton!
    @IBOutlet weak var Blue: UIButton!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let pickerView = UIPickerView()
    let radioController: RadioButtonController = RadioButtonController()
    var categoriesDB = [Category]()
    var selectedCategory: Category?
    var date: String?
    var selectedColor: String?
    var strDate: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//                let item = Item()
//                iName = item.title!
////                color = item.color!
////                dName = item.date!
////                cName = item.parentCategory?.name!
//                self.saveItems()
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
    }
    //    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {
    //
    //        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
    //
    //        if let addtionalPredicate = predicate {
    //            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, addtionalPredicate])
    //        } else {
    //            request.predicate = categoryPredicate
    //        }
    //
    //
    //        do {
    //            itemArray = try context.fetch(request)
    //        } catch {
    //            print("Error fetching data from context \(error)")
    //        }
    //
    //        tableView.reloadData()
    //
    //    }
}
