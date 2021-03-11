//
//  IngredientEntryViewController.swift
//  HANGRY
//
//  Created by Dua Almahyani on 09/11/2020.
//

import UIKit

class IngredientEntryViewController: UIViewController  {

    @IBOutlet var ingredientTextField: UITextField!
    @IBOutlet var categoryTextField: UITextField!
    @IBOutlet var quantityTextField: UITextField!
    @IBOutlet var unitTextField: UITextField!
    @IBOutlet var expireDate: UIDatePicker!
    @IBOutlet var pickImage: UIImageView!
    
    var delegate: dataDelegate?
    var quntityNum: Int = 0
    var categoryPickerView = UIPickerView()
    var unitPickerView = UIPickerView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryTextField.inputView = categoryPickerView
        unitTextField.inputView = unitPickerView
        
        
        categoryPickerView.delegate = self
        categoryPickerView.dataSource = self
        
        
        unitPickerView.delegate = self
        unitPickerView.dataSource = self
        
        categoryPickerView.tag = 1
        unitPickerView.tag = 2
        dismissAndClosePickerView()
        changeAttribute()
    }
    
    func changeAttribute() {
        Utilities.styleTextField(ingredientTextField)
        Utilities.styleTextField(categoryTextField)
        Utilities.styleTextField(quantityTextField)
        Utilities.styleTextField(unitTextField)
        pickImage.image = #imageLiteral(resourceName: "pickImage")
        pickImage.layer.cornerRadius = 9
        
        
        
    }
    
    
    func dismissAndClosePickerView() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.dissmissAction))
        toolbar.setItems([button], animated: true)
        toolbar.isUserInteractionEnabled = true
        self.categoryTextField.inputAccessoryView = toolbar
        self.unitTextField.inputAccessoryView = toolbar
        
    }

    @IBAction func saveButtonTapped(_ sender: UIButton) {
        quntityNum = Int(quantityTextField.text ?? "") ?? 0
        let ingredient = Ingredient(name: ingredientTextField.text!, category: categoryTextField.text!, expiresDate: expireDate.date, quntity: quntityNum, unit: unitTextField.text!)
        delegate?.addIngredient(ingredient)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func dissmissAction() {
        self.view.endEditing(true)
    }
}

extension IngredientEntryViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return Category.allCases.count
        case 2:
            return measuringUnit.allCases.count
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return Category.allCases[row].rawValue
        case 2:
            return measuringUnit.allCases[row].rawValue
        default:
            return "nothing to show :("
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            categoryTextField.text =  Category.allCases[row].rawValue
        case 2:
            unitTextField.text = measuringUnit.allCases[row].rawValue
        default:
            break
        }
    }
    
}
