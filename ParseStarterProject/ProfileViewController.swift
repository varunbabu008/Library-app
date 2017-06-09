//
//  ProfileViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Varun Babu on 6/5/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {

    @IBOutlet var logoutButton: UIView!
    
    @IBOutlet var usernameLabel: UILabel!
    @IBAction func logoutButtonFun(_ sender: Any) {
        
        
        
        displayAlert(title: "Are you sure you wanna Logout", message: "Logout")
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        usernameLabel.text = PFUser.current()?.username
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func displayAlert(title: String, message: String){
        
        let alertcontroller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        // if the user presses ok. Perform Logout Logic
        alertcontroller.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in
            
            if(message == "Logout"){
                PFUser.logOut()
                self.performSegue(withIdentifier: "loginPage", sender: self)
                
            }
            
        }))
        //Do nothing if the user cancels
        alertcontroller.addAction(UIAlertAction(title: "Cancel", style: .default, handler: {_ in
            
        }))
        
        
        
        self.present(alertcontroller, animated: true, completion: nil)
        
    }


}
