//
//  ViewController.swift
//  DataTransferUsingAppDelegate
//
//  Created by Nikhil Patil on 25/01/19.
//  Copyright © 2019 Nikhil Patil. All rights reserved.
//

import UIKit
import SVProgressHUD
import SCLAlertView

class ViewController: UIViewController,UITextFieldDelegate {

    // IBOulet variables
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var mobileNoTF: UITextField!
    @IBOutlet weak var ageTF: UITextField!
    
    // Var for LeftViewMode Image
    var icon1ImageView = UIImageView(frame: CGRect.init(x: 20, y: 0, width: 40, height: 30))
    var icon2ImageView = UIImageView(frame: CGRect.init(x: 20, y: 0, width: 40, height: 30))
    var icon3ImageView = UIImageView(frame: CGRect.init(x: 20, y: 0, width: 40, height: 30))
    var icon4ImageView = UIImageView(frame: CGRect.init(x: 20, y: 0, width: 40, height: 30))
    
    var appDelRef:AppDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // For LeftViewMode image
        
        icon1ImageView.image = UIImage(named: "first name")
        firstNameTF.leftView = icon1ImageView
        firstNameTF.leftViewMode = .always
        
        icon2ImageView.image = UIImage(named: "last name")
        lastNameTF.leftView = icon2ImageView
        lastNameTF.leftViewMode = .always
        
        icon3ImageView.image = UIImage(named: "Age")
        ageTF.leftView = icon3ImageView
        ageTF.leftViewMode = .always
        
        icon4ImageView.image = UIImage(named: "Mobile No")
        mobileNoTF.leftView = icon4ImageView
        mobileNoTF.leftViewMode = .always
        
        // Values Remains on place while click back button
        
        appDelRef = UIApplication.shared.delegate as? AppDelegate
        
        if(appDelRef.firstName != nil && appDelRef.lastName != nil && appDelRef.mobileNo != nil && appDelRef.age != nil)
        {
            firstNameTF.text = appDelRef.firstName
            lastNameTF.text = appDelRef.lastName
            mobileNoTF.text = appDelRef.mobileNo
            ageTF.text = appDelRef.age
        }
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    // Cocoa Pod of Loading...
    override func viewDidAppear(_ animated: Bool) {
        SVProgressHUD.show(withStatus: "Personal Details")
        SVProgressHUD.setBackgroundColor(#colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1))
        SVProgressHUD.dismiss(withDelay: 1)
    }
    
    // Alert funcs
    func alert(title: String, message: String ){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func alertMessage(message: String){
        
        let alert = UIAlertController(title: "Waring", message: message, preferredStyle: .alert)
        present(alert,animated: true, completion: nil)
        
        alert.addAction(UIAlertAction(title: "Please Fill Correct Detail", style: .default, handler: { (UIAlertAction) in
            
        }))
    }
   
    // Button Action for PassData and Goto Next View Controller
    
    @IBAction func nextBtnAction(_ sender: Any) {
        if(firstNameTF.text == "" || lastNameTF.text == "" || mobileNoTF.text == "" || ageTF.text == "" )
        {
//            alert(title: "WARNING", message: "All Field are Requied To Be Filled")
            let appearance = SCLAlertView.SCLAppearance(dynamicAnimatorActive: true)
            _ = SCLAlertView(appearance: appearance).showNotice("Warning", subTitle: "All FIELD ARE REQUIRED TO BE FILLED")
        }
        else if (Int(ageTF.text!)! < 1 || Int(ageTF.text!)! > 120 )
        {
//            alertMessage(message: "Please Enter Valid Age")
            _ = SCLAlertView().showError("Hold On...", subTitle:"Enter Valid Age", closeButtonTitle:"OK")
        }
        else {
        
            appDelRef.firstName = firstNameTF.text!
            appDelRef.lastName = lastNameTF.text!
            appDelRef.mobileNo = mobileNoTF.text!
            appDelRef.age = ageTF.text!
            
            let nextVC = storyboard?.instantiateViewController(withIdentifier: "EducationalDetailsViewController") as! EducationalDetailsViewController
            present(nextVC, animated: true){
                
            }
        }
    }
    //Regular Expressions
    
    func isValidateName(name: String) -> Bool{
        let nameExp = "[a-zA-Z ]{1,10}"
        return NSPredicate(format: "SELF MATCHES %@", nameExp).evaluate(with: name)
    }
    
    func isValidationAge(age: String) -> Bool {
        let ageExp = "[0-9]{2}"
        return NSPredicate(format: "SELF MATCHES %@", ageExp).evaluate(with: age)
    }
    func isValidateMobile(mobileNo : String) -> Bool {
        let mobileExp = "[5-9]{10}"
        return NSPredicate(format: "SELF MATCHES %@", mobileExp).evaluate(with: mobileNo)
    }
    
    // Delegate Functions
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        var returnValue: Bool = false
        
        if textField == firstNameTF{
            returnValue = true
        }else if textField == lastNameTF{
            
            if isValidateName(name: firstNameTF.text!) == true {
                returnValue = true
            }else{
//                alertMessage(message: "First Name Must Have Text Only")
                _ = SCLAlertView().showWarning("Warning", subTitle: "First Name Must Have Text Only")
            }
            
        }else if textField == mobileNoTF {
            if isValidateName(name: lastNameTF.text!) == true {
                returnValue = true
            }else{
                _ = SCLAlertView().showWarning("Warning", subTitle: "Last Name Must Have Text Only")
//                alertMessage(message: "Last Name Must Have Text Only")
            }
            
        }else if textField == ageTF{
            if isValidateMobile(mobileNo: mobileNoTF.text!) == true {
                returnValue = true
            }else{
//                alertMessage(message: "Enter 10 Digit Mobile No.")
                _ = SCLAlertView().showWarning("Warning", subTitle: "Enter 10 Digit Mobile No.")
            }
            returnValue = true
        }
        return returnValue
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let numChar = CharacterSet(charactersIn: "0123456789")
        
        if (string.count == 0){
            return true
        }
        
        if textField == ageTF || textField == mobileNoTF {
            if string.rangeOfCharacter(from: numChar) != nil
            {
                return true
            }
            else{
                return false
            }
        }
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
}

