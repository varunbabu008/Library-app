/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse

class ViewController: UIViewController {

    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var passWordTextField: UITextField!
    
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var signUpButton: UIButton!
    
    
    var signUpMode = true
    
    @IBAction func login(_ sender: Any) {
        
        
    }
    
    
    @IBAction func signUp(_ sender: Any) {
        
        
        if(userNameTextField.text == "" || passWordTextField.text == ""){
            displayAlert(title: "Error in form", message: "username and password are required")
        }
        
        else{
            
            if signUpMode{
                
                let user = PFUser()
                
                user.username = userNameTextField.text
                user.password = passWordTextField.text
                
                user.signUpInBackground(block: { (success, error) in
                    
                    if let error = error{
                        
                        var displayedErrorMessage = "Please try again later"

                        if let parseError = ((error as Any) as! NSError).userInfo["error"] as? String{
                            
                            displayedErrorMessage = parseError
                            
                        }
                        
                        self.displayAlert(title: "Sign Up Failed", message: displayedErrorMessage)
                    }
                    
                    else{
                        
                        //var signUpMessage = "Sign Up Successful"
                        
                        self.displayAlert(title: "Sign up Succesful", message: "")
                        
                        
                        
                        
                    }
                    
                    
                    
                    
                })
                
                
            }
            
            
            
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayAlert(title: String, message: String){
        
        let alertcontroller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertcontroller.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alertcontroller, animated: true, completion: nil)
        
    }

    
}
