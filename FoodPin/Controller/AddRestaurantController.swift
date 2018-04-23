//
//  AddRestaurantController.swift
//  FoodPin
//
//  Created by Gerson Costa on 01/04/2018.
//  Copyright © 2018 Gerson Costa. All rights reserved.
//

import UIKit
import CoreData

class AddRestaurantController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    
    var restaurant: RestaurantMO!
    var name = ""
    var type = ""
    var location = ""
    var phoneNumber = ""
    var imageSelected = false
    var beenHere: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
        typeTextField.delegate = self
        locationTextField.delegate = self
        phoneTextField.delegate = self
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.selectionStyle = .none
        if indexPath.row == 0 {
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .photoLibrary
                
                present(imagePicker, animated: true, completion: nil)
            }
        }
        if nameTextField.isEditing {
            nameTextField.endEditing(true)
        }
        if typeTextField.isEditing {
            typeTextField.endEditing(true)
        }
        if locationTextField.isEditing {
            locationTextField.endEditing(true)
        }
        if phoneTextField.isEditing {
            phoneTextField.endEditing(true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            photoImageView.image = selectedImage
            photoImageView.contentMode = .scaleAspectFill
            photoImageView.clipsToBounds = true
            imageSelected = true
        }
        
        // Programmatically constraints
        let leadingConstraint = NSLayoutConstraint(item: photoImageView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: photoImageView.superview, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        leadingConstraint.isActive = true
        
        let trailingConstraint = NSLayoutConstraint(item: photoImageView, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: photoImageView.superview, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
        trailingConstraint.isActive = true
        
        let topConstraint = NSLayoutConstraint(item: photoImageView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: photoImageView.superview, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        topConstraint.isActive = true
        
        let bottomConstraint = NSLayoutConstraint(item: photoImageView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: photoImageView.superview, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        bottomConstraint.isActive = true
        
        dismiss(animated: true, completion: nil)
    }

    @IBAction func beenHereBtnPressed(_ sender: UIButton) {
        if sender.tag == 1 {
            yesButton.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
            noButton.backgroundColor = #colorLiteral(red: 0.7490196078, green: 0.7490196078, blue: 0.7490196078, alpha: 1)
            beenHere = true
        } else if sender.tag == 2 {
            yesButton.backgroundColor = #colorLiteral(red: 0.7490196078, green: 0.7490196078, blue: 0.7490196078, alpha: 1)
            noButton.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
            beenHere = false
        }
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        
        if let tempName = nameTextField.text {
            name = tempName
        }
        if let tempType = typeTextField.text {
            type = tempType
        }
        if let tempLocation = locationTextField.text {
            location = tempLocation
        }
        if let tempNumber = phoneTextField.text {
            phoneNumber = tempNumber
        }
        
        if name == "" || type == "" || location == "" || phoneNumber == "" {
            errorAlert(message: "One or more fields are empty!")
        } else if imageSelected == false {
            errorAlert(message: "Image is missing!")
        } else {
            print("""
                Name: \(name)
                Type: \(type)
                Location: \(location)
                Phone Number: \(phoneNumber)
                Have you been here? = \(beenHere)
""")
            
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                restaurant = RestaurantMO(context: appDelegate.persistentContainer.viewContext)
                restaurant.name = nameTextField.text
                restaurant.type = typeTextField.text
                restaurant.location = locationTextField.text
                restaurant.phone = phoneTextField.text
                restaurant.isVisited = beenHere
                
                if let restaurantImage = photoImageView.image {
                    if let imageData = UIImagePNGRepresentation(restaurantImage) {
                        restaurant.image = Data(imageData)
                    }
                }
                
                print("Saving data to context...")
                appDelegate.saveContext()
                
            }
            
            successAlert(message: "Restaurant saved successfully!")
            
            nameTextField.text = ""
            typeTextField.text = ""
            locationTextField.text = ""
            phoneTextField.text = ""
            
            performSegue(withIdentifier: "unwindToHomeScreen", sender: self)
        }
     
    }
    
    func successAlert(message: String) {
        let alert = UIAlertController(title: "Success", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
    
    func errorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Review", style: .default, handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case nameTextField:
            typeTextField.becomeFirstResponder()
        case typeTextField:
            locationTextField.becomeFirstResponder()
        case locationTextField:
            phoneTextField.becomeFirstResponder()
        default:
            phoneTextField.resignFirstResponder()
        }
        
        return true
    }

}
