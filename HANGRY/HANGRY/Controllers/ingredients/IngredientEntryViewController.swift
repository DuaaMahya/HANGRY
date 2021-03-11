//
//  IngredientEntryViewController.swift
//  HANGRY
//
//  Created by Dua Almahyani on 09/11/2020.
//

import UIKit

class IngredientEntryViewController: UIViewController, UITextFieldDelegate  {

    @IBOutlet var ingredientTextField: UITextField!
    @IBOutlet var categoryTextField: UITextField!
    @IBOutlet var quantityTextField: UITextField!
    @IBOutlet var unitTextField: UITextField!
    @IBOutlet var expireDate: UIDatePicker!
    @IBOutlet var imagePickerButton: UIButton!
    
    var key = String()
    
    var delegate: ingredientDataDelegate?
    var photoDele: photoDelegate?
    
    var quntityNum: Int = 0
    
    var categoryPickerView = UIPickerView()
    var unitPickerView = UIPickerView()
    
    var imageStore = ImageStore()
    
    
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
        key = UUID().uuidString
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Get the item key
        //let key = ingredient.ingredientKey
        // If there is an associated image with the item, display it on the image view
//        let imageToDisplay = imageStore.image(forKey: key)
//        imagePickerButton.setImage(imageToDisplay, for: .normal)
    }
    
    func changeAttribute() {
        Utilities.styleTextField(ingredientTextField)
        Utilities.styleTextField(categoryTextField)
        Utilities.styleTextField(quantityTextField)
        Utilities.styleTextField(unitTextField)
        imagePickerButton.setImage(#imageLiteral(resourceName: "pickImage").withRenderingMode(.alwaysOriginal), for: .normal)
        imagePickerButton.layer.cornerRadius = 9
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func pickImageTapped(_ sender: UIButton) {
        showImagePickerController()
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        quntityNum = Int(quantityTextField.text ?? "") ?? 0
        let ingredient = Ingredient(name: ingredientTextField.text!, category: categoryTextField.text!, expiresDate: expireDate.date, quntity: quntityNum, unit: unitTextField.text!)
        ingredient.ingredientKey = self.key
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

extension IngredientEntryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func showImagePickerController() {
        let alertController = UIAlertController(title: nil,
                                                message: nil,
                                                preferredStyle: .actionSheet)
        
        alertController.modalPresentationStyle = .popover
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = true
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { _ in
            let imagePicker = self.imagePicker(for: .photoLibrary)
            imagePicker.allowsEditing = true
            imagePicker.modalPresentationStyle = .popover
            self.present(imagePicker, animated: true, completion: nil)
        }
        
        alertController.addAction(photoLibraryAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            //photoDele?.passPhoto(key)
            print("\n\n\n HERE:------------------ \n\(key)\n\n")
            imageStore.setImage(editedImage, forKey: key)
            imagePickerButton.setImage(editedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            //photoDele?.passPhoto(key)
            imageStore.setImage(originalImage, forKey: key)
            imagePickerButton.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePicker(for sourceType: UIImagePickerController.SourceType) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        return imagePicker
    }
}
