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
import ParseFacebookUtilsV4

class ViewController: UIViewController {

    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var passWordTextField: UITextField!
    
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var signUpButton: UIButton!
    
    
    var signUpMode = true
    
    @IBAction func login(_ sender: Any) {
        
        if(userNameTextField.text == "" || passWordTextField.text == ""){
            displayAlert(title: "Error in form", message: "username and password are required")
        }
        
        PFUser.logInWithUsername(inBackground: userNameTextField.text!, password: passWordTextField.text!) { (user, error) in
            

            
            if let error = error{
                
                var displayedErrorMessage = "Please try again later"
                
                if let parseError = ((error as Any) as! NSError).userInfo["error"] as? String{
                    
                    displayedErrorMessage = parseError
                    
                }
                
                self.displayAlert(title: "Login  failed", message: displayedErrorMessage)
                
            }
            
            else{
                
                
                self.displayAlert(title: "Login Succesful", message: "Login Successful")
                //Perfomr segue to be done
                
                //self.performSegue(withIdentifier: "booksPage", sender: self)
                

                
                
                
            }
            
            
        }
        
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return true
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
                        
                        self.displayAlert(title: "Sign up Succesful", message: "Signup Successfull")
                        
                        // To be done. Perform Segue with Identifier
                        
                        
                    }
                    
                    
                    
                    
                })
                
                
            }
            
            
            
        }
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        
//        let permissions = ["public_profile"]
//        PFFacebookUtils.logInInBackground(withReadPermissions: permissions) { (user, error) in
//            
//            if let error = error{
//                
//                print(error)
//                
//            }
//            
//            else{
//                
//                if let user = user{
//                    
//                    print(user)
//                    
//                }
//                
//                
//            }
//            
//            
//        }
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
//        let permissions = ["public_profile"]
//                PFFacebookUtils.logInInBackground(withReadPermissions: permissions) { (user, error) in
//                    
//                    if let error = error{
//        
//                        print(error)
//        
//                    }
//        
//                    else{
//                        print("Hello")
//                        if let user = user{
//                            print("aaaaa")
//                            print(user)
//        
//                        }
//                        
//                        
//                    }
//                    
//                    
//                }
//        print("varun")
////
        

    }
//action in self.performSegue(withIdentifier: "booksPage", sender: self)
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayAlert(title: String, message: String){
        
        let alertcontroller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertcontroller.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in
            //login unsuccesful if the message us not "Login Successful"
            if(message == "Login Successful"){
                self.performSegue(withIdentifier: "booksPage", sender: self)

            }
            
        }))
        
        self.present(alertcontroller, animated: true, completion: nil)
        
    }

    
}
