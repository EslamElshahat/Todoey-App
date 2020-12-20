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

class EditItemViewController: UIViewController,UITextFieldDelegate {
    
    var FmItem: Item?
    
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
    var strDate: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
        print(FmItem?.date)
//        let dateFormatter = ISO8601DateFormatter()
//        let date = dateFormatter.date(from:(FmItem?.date)!)!
//        datePicker.date = FmItem?.date! ?? Date
        
        itemName.text = FmItem?.title!
        CategoryName.text = FmItem?.parentCategory?.name
        
        pickerView.delegate = self
//        CategoryName.inputView = pickerView
//        if FmItem?.color == "Red" {
//            radioController.buttonsArray = [Red,Green,Blue]
//            radioController.defaultButton = Red
//        } else if FmItem?.color == "Green" {
//            radioController.buttonsArray = [Red,Green,Blue]
//            radioController.defaultButton = Green
//        } else {
//            radioController.buttonsArray = [Red,Green,Blue]
//            radioController.defaultButton = Blue
//        }
//////        item.date = dName!
        
        self.saveItems()
    }
    
    func loadCategories(){
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        do{
            categoriesDB = try context.fetch(request)
            //            for category in categoriesDB {
            //                categories.append(category)
            //            }
        }catch{
            print("Error")
        }
    }
    
    @IBAction func datePickerChanged(_ sender: Any) {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        
        self.strDate = datePicker.date
        //        print(strDate)
    }
    
    @IBAction func btnRedAction(_ sender: UIButton) {
        radioController.buttonArrayUpdated(buttonSelected: sender)
        selectedColor = "Red"
        
        //        print(selectedColor)
    }
    @IBAction func btnGreenAction(_ sender: UIButton) {
        radioController.buttonArrayUpdated(buttonSelected: sender)
        selectedColor = "Green"
        //        print(selectedColor)
    }
    @IBAction func btnBlueAction(_ sender: UIButton) {
        radioController.buttonArrayUpdated(buttonSelected: sender)
        selectedColor = "Blue"
        //        print(selectedColor)
    }
    
    @IBAction func saveEdit(_ sender: UIButton) {
//        let editItem = Item(context: self.context)

//        print(editItem)
        FmItem!.title = itemName?.text!
        FmItem!.parentCategory? = selectedCategory!
        FmItem!.color = selectedColor!
        FmItem!.date = strDate!
        FmItem!.done = false
        do{
            try context.save()
        }catch{
            print("Error")
        }
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
}

extension EditItemViewController: UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoriesDB.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoriesDB[row].name
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedCategory = categoriesDB[row]
        self.CategoryName.text = categoriesDB[row].name
        self.view.endEditing(true)
        pickerView.isHidden = true
    }
    
}

class EditRadioButtonController: NSObject {
    var buttonsArray: [UIButton]! {
        didSet {
            for b in buttonsArray {
                b.setImage(UIImage(named: "unchecked-radio"), for: .normal)
                b.setImage(UIImage(named: "checked-radio"), for: .selected)
            }
        }
    }
    var selectedButton: UIButton?
    var defaultButton: UIButton = UIButton() {
        didSet {
            buttonArrayUpdated(buttonSelected: self.defaultButton)
        }
    }
    
    func buttonArrayUpdated(buttonSelected: UIButton) {
        for b in buttonsArray {
            if b == buttonSelected {
                selectedButton = b
                b.isSelected = true
            } else {
                b.isSelected = false
            }
        }
    }
}
