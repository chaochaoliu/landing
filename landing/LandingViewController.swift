//
//  ViewController.swift
//  landing
//
//  Created by Chao Liu on 7/27/15.
//  Copyright (c) 2015 OIT. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {

    
    @IBOutlet var signupBtn: UIButton!
    
    @IBOutlet var signinBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        signinBtn.layer.cornerRadius = 10
        signinBtn.layer.borderWidth = 1.5
        signinBtn.layer.borderColor = UIColor.whiteColor().CGColor
        
        signupBtn.layer.cornerRadius = 10
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = true
        
        var prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        let isLoggedIn = prefs.integerForKey("ISLOGGEDIN")
        
        println(isLoggedIn)
    }

}

