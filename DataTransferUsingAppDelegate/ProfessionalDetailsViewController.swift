//
//  ProfessionalDetailsViewController.swift
//  DataTransferUsingAppDelegate
//
//  Created by Nikhil Patil on 25/01/19.
//  Copyright © 2019 Nikhil Patil. All rights reserved.
//

import UIKit
import SVProgressHUD
import SCLAlertView

class ProfessionalDetailsViewController: UIViewController,UITextFieldDelegate {

   // IBOutlet Variables
    @IBOutlet weak var companyNameTF: UITextField!
    @IBOutlet weak var designationTF: UITextField!
    @IBOutlet weak var salaryTF: UITextField!
    @IBOutlet weak var companyAddressTF: UITextField!
    
    var appDelRef:AppDelegate!
    let kDefaultAnimationDuration = 2.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Values Remains on place while click back button
        appDelRef = UIApplication.shared.delegate as? AppDelegate
        
        if(appDelRef.companyName != nil && appDelRef.designation != nil && appDelRef.salary != nil && appDelRef.companyAddress != nil)
        {
            companyNameTF.text = appDelRef.companyName
            designationTF.text = appDelRef.designation
            salaryTF.text = appDelRef.salary
            companyAddressTF.text = appDelRef.companyAddress
        }
        
        // Do any additional setup after loading the view.
    }
    
    // Cocoa Pod of Loading...
    override func viewDidAppear(_ animated: Bool) {
        SVProgressHUD.show(withStatus: "Professional Details")
        SVProgressHUD.setBackgroundColor(#colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1))
        SVProgressHUD.dismiss(withDelay: 1)
    }
    
    // Button Action for PassData and Goto Next View Controller

    @IBAction func nextBtnAction(_ sender: Any) {
        
        if(companyNameTF.text == "" || designationTF.text == "" || salaryTF.text == "" || companyAddressTF.text == "" )
        {
//            alert(title: "WARNING", message: "All Field are Requied To Be Filled")
            let appearance = SCLAlertView.SCLAppearance(dynamicAnimatorActive: true)
            _ = SCLAlertView(appearance: appearance).showNotice("Warning", subTitle: "All FIELD ARE REQUIRED TO BE FILLED")
        }
        else{
            appDelRef.companyName = companyNameTF.text!
            appDelRef.designation = designationTF.text!
            appDelRef.salary = salaryTF.text!
            appDelRef.companyAddress = companyAddressTF.text!
            
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "SummaryDetailsViewController") as! SummaryDetailsViewController
        present(nextVC, animated: true){
            
            // Custom Alert Using Cocoa Pods
            let appearance = SCLAlertView.SCLAppearance(
                showCloseButton: false
            )
            
            let alert = SCLAlertView(appearance: appearance).showWait("Downloading Your Details", subTitle: "Processing...", closeButtonTitle: nil, timeout: nil, colorStyle: nil, colorTextButton: 0xFFFFFF, circleIconImage: nil, animationStyle: SCLAnimationStyle.topToBottom)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                alert.setSubTitle("Progress: 10%")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    alert.setSubTitle("Progress: 30%")
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        alert.setSubTitle("Progress: 50%")
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            alert.setSubTitle("Progress: 70%")
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                alert.setSubTitle("Progress: 90%")
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                    alert.close()
                                }
                            }
                        }
                    }
                }
            }
        }
            
                }
        }

    // Alert
    
    func alert(title: String, message: String ){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func alertControllerFunc(message: String){
        let alert = UIAlertController(title: "Warning", message: message, preferredStyle: .alert)
        present(alert, animated: true, completion: nil)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
        }))
    }

    // Delegate Functions
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let numCharacters = CharacterSet(charactersIn: "1234567890")
        let char = CharacterSet.alphanumerics
        
        if(string.count == 0)
        {
            return true
        }
        
        if(textField == companyNameTF || textField == designationTF || textField == companyAddressTF ){
            if((string.rangeOfCharacter(from: char)) != nil)
            {
                return true
            }else{
                return false
            }
        }
        
        if(textField == salaryTF){
            if((string.rangeOfCharacter(from: numCharacters)) != nil)
            {
                return true
            }else{
                return false
            }
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
}
