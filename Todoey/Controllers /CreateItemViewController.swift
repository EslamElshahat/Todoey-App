//
//  CreateItemViewController.swift
//  Todoey
//
//  Created by Eslam Elshaht on 11/26/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import UIKit
import CoreData


class CreateItemViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var itemName: UITextField!
    @IBOutlet weak var CategoryName: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var Red: UIButton!
    @IBOutlet weak var Green: UIButton!
    @IBOutlet weak var Blue: UIButton!
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate    ).persistentContainer.viewContext
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
        pickerView.delegate = self
        CategoryName.inputView = pickerView
        radioController.buttonsArray = [Red,Green,Blue]
        radioController.defaultButton = Red
        
    }
    
    func loadCategories(){
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        do{
            categoriesDB = try context.fetch(request)
            
        }catch{
            print("Error")
        }
    }
    
    
    
    @IBAction func datePickerChanged(_ sender: Any) {
        let dateFormatter = ISO8601DateFormatter()
        self.strDate = datePicker.date
    }
    //radios start
    @IBAction func btnRedAction(_ sender: UIButton) {
        radioController.buttonArrayUpdated(buttonSelected: sender)
        selectedColor = "Red"
    }
    @IBAction func btnGreenAction(_ sender: UIButton) {
        radioController.buttonArrayUpdated(buttonSelected: sender)
        selectedColor = "Green"
    }
    @IBAction func btnBlueAction(_ sender: UIButton) {
        radioController.buttonArrayUpdated(buttonSelected: sender)
        selectedColor = "Blue"
    }
    
    
    
    @IBAction func createButton(_ sender: UIButton) {
        
        let newItem = Item(context: self.context)
        newItem.title = itemName?.text!
        newItem.parentCategory = selectedCategory!
        newItem.color = selectedColor ?? "Red"
        newItem.date = self.strDate!
        newItem.done = false
        do{
            try context.save()
        }catch{
            print("Error")
        }
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CategoryTableViewController") as? CategoryTableViewController
        navigationController?.pushViewController(vc!, animated: true)
        
    }
    func saveItems(){
        do{
            try context.save()
        }catch{
            
            print("Error")
        }
    }
}
extension CreateItemViewController: UIPickerViewDelegate,UIPickerViewDataSource{
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


class RadioButtonController: NSObject {
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
