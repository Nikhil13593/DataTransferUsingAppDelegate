//
//  SummaryDetailsViewController.swift
//  DataTransferUsingAppDelegate
//
//  Created by Nikhil Patil on 25/01/19.
//  Copyright © 2019 Nikhil Patil. All rights reserved.
//

import UIKit
import SVProgressHUD
import SCLAlertView

class SummaryDetailsViewController: UIViewController {

    // IBOutlet Variables
    @IBOutlet weak var firstNameLbl: UILabel!
    @IBOutlet weak var lastNameLbl: UILabel!
    @IBOutlet weak var mobileNoLbl: UILabel!
    @IBOutlet weak var ageLbl: UILabel!
    
    @IBOutlet weak var tenthResultLbl: UILabel!
    @IBOutlet weak var interResultLbl: UILabel!
    @IBOutlet weak var BTECHResultLbl: UILabel!
    @IBOutlet weak var MTECHResultlbl: UILabel!
    
    @IBOutlet weak var companyNameLbl: UILabel!
    @IBOutlet weak var designationLbl: UILabel!
    @IBOutlet weak var salaryLbl: UILabel!
    @IBOutlet weak var companyAddressTV: UITextView!
    
    var appDelRef:AppDelegate!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Assigning Values to Labels for Output
        appDelRef = UIApplication.shared.delegate as? AppDelegate
        
        firstNameLbl.text = appDelRef.firstName
        lastNameLbl.text = appDelRef.lastName
        mobileNoLbl.text = appDelRef.mobileNo
        ageLbl.text = appDelRef.age
        
        tenthResultLbl.text = appDelRef.tenthResult
        interResultLbl.text = appDelRef.interResult
        BTECHResultLbl.text = appDelRef.BTECHResult
        MTECHResultlbl.text = appDelRef.MTECHResult
        
        companyNameLbl.text = appDelRef.companyName
        designationLbl.text = appDelRef.designation
        salaryLbl.text = appDelRef.salary
        companyAddressTV.text = appDelRef.companyAddress

        // Do any additional setup after loading the view.
    }
    
    // On Home Btn Action Make The all strings Clear
    @IBAction func homeBtnAction(_ sender: Any) {
        appDelRef.firstName = ""
        appDelRef.lastName = ""
        appDelRef.mobileNo = ""
        appDelRef.age = ""
        appDelRef.tenthResult = ""
        appDelRef.interResult = ""
        appDelRef.BTECHResult = ""
        appDelRef.MTECHResult = ""
        appDelRef.companyName = ""
        appDelRef.designation = ""
        appDelRef.salary = ""
        appDelRef.companyAddress = ""
    }
    

}
