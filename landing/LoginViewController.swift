//
//  LoginViewController.swift
//  landing
//
//  Created by Chao Liu on 7/28/15.
//  Copyright (c) 2015 OIT. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var signinBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        for field in [emailField, passwordField]{
           field.layer.cornerRadius = 0
            field.layer.borderWidth = 1.5
            field.layer.borderColor = UIColor.whiteColor().CGColor
            
            let attributes = [
            NSForegroundColorAttributeName: UIColor.greenColor(),
            NSFontAttributeName : UIFont (name:"Avenir-Medium",  size:17.0)!]
            
            field.attributedPlaceholder = NSAttributedString(string:field.placeholder!,
                attributes:attributes)
        }
        
        signinBtn.layer.cornerRadius = 10
        
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    @IBAction func signinBtnTapped(sender: AnyObject) {
    
        if  emailField.text.isEmpty {
            
            displayAlertMessage("ERROR", alertDescription: "Please enter your email address")
            
            return

        }
        
        if !isValidEmail(emailField.text) {
            
            displayAlertMessage("ERROR", alertDescription: "Please enter a valid email address")
            
            return
        }

        
        if passwordField.text.isEmpty {
            
            displayAlertMessage("ERROR", alertDescription: "Please enter your password")
        
            return
        
        }
        
        for field in[emailField,passwordField] {
            
            if field.isFirstResponder() {
                field.resignFirstResponder()
            }
        }
        
        let overlayView = UIView(frame: view.frame)
        overlayView.backgroundColor = UIColor.blackColor()
        overlayView.alpha = 0.6
        view.addSubview(overlayView)
        
        let aiWrapperView = UIView(frame: CGRectMake(0, 0, 100, 100))
        aiWrapperView.center = view.center
        aiWrapperView.backgroundColor = UIColor.blackColor()
        aiWrapperView.layer.cornerRadius = 5
        view.addSubview(aiWrapperView)
        
        let ai = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        
        ai.center = view.center
        view.addSubview(ai)
        
        ai.startAnimating()
        
        let networkManager = NetworkManager()
        
        networkManager.manager.request(.POST, "http://52.24.143.251/user.login", parameters: ["email":emailField.text,"password":passwordField.text], encoding: .JSON, headers: nil)
                    .responseJSON { (req, res, json, error) in
                        overlayView.removeFromSuperview()
                        aiWrapperView.removeFromSuperview()
                        ai.removeFromSuperview()
                        
                        if(error != nil) {
                            self.displayAlertMessage("Error", alertDescription: error!.localizedDescription as NSString)}
                        else {
        
                            var json = JSON(json!)
                            
                            if json["status"].string != "200" && json["status"].string != "1" {
                                if let detail = json["detail"].string {
                                    self.displayAlertMessage("Error", alertDescription: detail as NSString)
                                }

                            }else{
                                var prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                                
                                prefs.setInteger(1, forKey: "ISLOGGEDIN")
                                
                                prefs.synchronize()
                                
                                let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("LandingViewController") as! UIViewController
                                
                                self.navigationController?.pushViewController(viewController, animated: true)
                            }
                }
        
      }
    
    }

}











