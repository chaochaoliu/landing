//
//  SignuoViewController.swift
//  landing
//
//  Created by Chao Liu on 8/20/15.
//  Copyright (c) 2015 OIT. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
    @IBOutlet var firstNameField: UITextField!
    @IBOutlet var lastNameField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var emailPasswordField: UITextField!
    
    @IBOutlet var submitBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for field in [firstNameField,lastNameField, emailField, emailPasswordField]{
            field.layer.cornerRadius = 0
            field.layer.borderWidth = 1.5
            field.layer.borderColor = UIColor.whiteColor().CGColor
            
            let attributes = [
                NSForegroundColorAttributeName: UIColor.greenColor(),
                NSFontAttributeName : UIFont (name:"Avenir-Medium",  size:17.0)!]
            
            field.attributedPlaceholder = NSAttributedString(string:field.placeholder!,
                attributes:attributes)
        }
        
        submitBtn.layer.cornerRadius = 10
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true


    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = false
    }
    
    func isValidEmail(testStr:String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Z0-9a-z._%+-]+\\.[A-Za-z]{2,4}"
        
        var emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluateWithObject(testStr)
        return result
    }
    
    func displayAlertMessage(alertTitle: NSString, alertDescription: NSString, style: UIAlertControllerStyle = UIAlertControllerStyle.Alert) {
        
        let alertController = UIAlertController(title: alertTitle as String, message: alertDescription as String, preferredStyle: style)
        
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        
        alertController.addAction(UIAlertAction(title: "Go Back", style: UIAlertActionStyle.Default, handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }

    @IBAction func submitBtnTapped(sender: AnyObject) {
        if  firstNameField.text.isEmpty {
            
            displayAlertMessage("ERROR", alertDescription: "Please enter your first name")
            
            return
            
        }
        if  lastNameField.text.isEmpty {
            
            displayAlertMessage("ERROR", alertDescription: "Please enter your last name")
            
            return
            
        }
        if  emailField.text.isEmpty {
            
            displayAlertMessage("ERROR", alertDescription: "Please enter your email address")
            
            return
            
        }
        
        if !isValidEmail(emailField.text) {
            
            displayAlertMessage("ERROR", alertDescription: "Please enter a valid email address")
            
            return
        }
        
        
        if emailPasswordField.text.isEmpty {
            
            displayAlertMessage("ERROR", alertDescription: "Please enter your password")
            
            return
            
        }

        for field in[emailField,emailPasswordField] {
            
            if field.isFirstResponder() {
                field.resignFirstResponder()
            }
        }
    }
    
    


}
