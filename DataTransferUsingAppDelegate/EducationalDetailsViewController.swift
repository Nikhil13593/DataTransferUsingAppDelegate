//
//  EducationalDetailsViewController.swift
//  DataTransferUsingAppDelegate
//
//  Created by Nikhil Patil on 25/01/19.
//  Copyright © 2019 Nikhil Patil. All rights reserved.
//

import UIKit
import SVProgressHUD
import SCLAlertView

class EducationalDetailsViewController: UIViewController,UITextFieldDelegate {

    // IBOutlet Variables
    @IBOutlet weak var tenthResultTF: UITextField!
    @IBOutlet weak var interResultTF: UITextField!
    @IBOutlet weak var BTECHResultTF: UITextField!
    @IBOutlet weak var MTECHResultTF: UITextField!

    var appDelRef:AppDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Values Remains on place while click back button
        appDelRef = UIApplication.shared.delegate as? AppDelegate
        
        if(appDelRef.tenthResult != nil && appDelRef.interResult != nil && appDelRef.BTECHResult != nil && appDelRef.MTECHResult != nil)
        {
            tenthResultTF.text = appDelRef.tenthResult
            interResultTF.text = appDelRef.interResult
            BTECHResultTF.text = appDelRef.BTECHResult
            MTECHResultTF.text = appDelRef.MTECHResult
        }

        // Do any additional setup after loading the view.
    }
    
    // Cocoa Pod of Loading...
    override func viewDidAppear(_ animated: Bool) {
        SVProgressHUD.show(withStatus: "Educational Details")
        SVProgressHUD.setBackgroundColor(#colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1))
        SVProgressHUD.dismiss(withDelay: 1)
    }
    
    // Alert
    
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
        
        if(tenthResultTF.text == "" || interResultTF.text == "" || BTECHResultTF.text == "" || MTECHResultTF.text == "" )
        {
//            alert(title: "WARNING", message: "All Field are Requied To Be Filled")
            let appearance = SCLAlertView.SCLAppearance(dynamicAnimatorActive: true)
            _ = SCLAlertView(appearance: appearance).showNotice("Warning", subTitle: "All FIELD ARE REQUIRED TO BE FILLED")

        }
        else if (Double(MTECHResultTF.text!)! >= 100.0)
        {
//        alertMessage(message: "Please Enter Percenteage Bwtn 1% to 100%")
            _ = SCLAlertView().showError("Hold On...", subTitle:"Please Enter Percenteage Bwtn 1% to 100%", closeButtonTitle:"OK")
        }
        else{ appDelRef.tenthResult = tenthResultTF.text!
        appDelRef.interResult = interResultTF.text!
        appDelRef.BTECHResult = BTECHResultTF.text!
        appDelRef.MTECHResult = MTECHResultTF.text!
            
            let nextVC = storyboard?.instantiateViewController(withIdentifier: "ProfessionalDetailsViewController") as! ProfessionalDetailsViewController
            present(nextVC, animated: true){
                
            }
        }
    
    }

    // Regular Expression
    //^([0-9]+)?(\\.([0-9]{1,2})?)?$
//    func isValidationMarks(marks: String) -> Bool {
//        let markExp = "[0-9]{2}"
//        return NSPredicate(format: "SELF MATCHES %@", markExp).evaluate(with: marks)
//        
//    }
    
    // Delegate Functions
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
//        var returnValue: Bool = false
//
//        if textField == tenthResultTF{
//            returnValue = true
//        }else if textField == interResultTF {
//            if isValidationMarks(marks: tenthResultTF.text!) == true {
//                returnValue = true
//            }else{
////                alertMessage(message: "Please Enter Percenteage Bwtn 1% to 100%")
//                _ = SCLAlertView().showWarning("Warning", subTitle: "Please Enter Percenteage Bwtn 1% to 100%")
//            }
//
//        }else if textField == BTECHResultTF{
//            if isValidationMarks(marks: interResultTF.text!) == true {
//                returnValue = true
//            }else {
////                alertMessage(message: "Please Enter Percenteage Bwtn 1% to 100%")
//                _ = SCLAlertView().showWarning("Warning", subTitle: "Please Enter Percenteage Bwtn 1% to 100%")
//
//                returnValue = true
//            }
//        }
//        else if textField == MTECHResultTF{
//            if isValidationMarks(marks: BTECHResultTF.text!) == true {
//                returnValue = true
//            }else {
////                alertMessage(message: "Please Enter Percenteage Bwtn 1% to 100%")
//                _ = SCLAlertView().showWarning("Warning", subTitle: "Please Enter Percenteage Bwtn 1% to 100%")
//
//                returnValue = true
//            }
//        }
//        return returnValue
        
        var returnValue = false
        
        if(textField == tenthResultTF)
        {
            returnValue = true
        }
        else if(textField == interResultTF)
        {
            if(Double(tenthResultTF.text!)! >= 0.0 && Double(tenthResultTF.text!)! <= 100.0)
            {
                returnValue = true
            }
            else
            {
                 _ = SCLAlertView().showWarning("Warning", subTitle: "Please Enter Percenteage Bwtn 1% to 100%")
                returnValue = false
            }
        }
        else if(textField == BTECHResultTF)
        {
            if(Double(tenthResultTF.text!)! >= 0.0 && Double(tenthResultTF.text!)! <= 100.0 && Double(interResultTF.text!)! >= 0.0 && Double(interResultTF.text!)! <= 100.0)
            {
                returnValue = true
            }
            else
            {
                 _ = SCLAlertView().showWarning("Warning", subTitle: "Please Enter Percenteage Bwtn 1% to 100%")
                returnValue = false
            }
            
        }
        else if(textField == MTECHResultTF)
        {
            if(Double(tenthResultTF.text!)! >= 0.0 && Double(tenthResultTF.text!)! <= 100.0 && Double(interResultTF.text!)! >= 0.0 && Double(interResultTF.text!)! <= 100.0 && Double(BTECHResultTF.text!)! >= 0.0 && Double(BTECHResultTF.text!)! <= 100.0)
            {
                returnValue = true
            }
            else
            {
                 _ = SCLAlertView().showWarning("Warning", subTitle: "Please Enter Percenteage Bwtn 1% to 100%")
                returnValue = false
            }
            return returnValue
        }
        return returnValue
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let numChar = CharacterSet(charactersIn: "0123456789.")
        
        if (string.count == 0){
            return true
        }
        
        if textField == tenthResultTF || textField == interResultTF || textField == BTECHResultTF || textField == MTECHResultTF {
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
