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
    
    @IBAction func logoutButtonFun(_ sender: Any) {
        
        
        
        displayAlert(title: "Are you sure you wanna Logout", message: "Logout")
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayAlert(title: String, message: String){
        
        let alertcontroller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertcontroller.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in
            //login unsuccesful if the message us not "Login Successful"
            if(message == "Logout"){
                PFUser.logOut()
                self.performSegue(withIdentifier: "loginPage", sender: self)
                
            }
     
            
        }))
        
        alertcontroller.addAction(UIAlertAction(title: "Cancel", style: .default, handler: {_ in
            //login unsuccesful if the message us not "Login Successful"
                        
            
        }))
        
        
        
        self.present(alertcontroller, animated: true, completion: nil)
        
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
