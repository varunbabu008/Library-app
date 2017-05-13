//
//  PaymentsViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Varun Babu on 11/5/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import Stripe
import AFNetworking

class PaymentsViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var cardNumberTextField: UITextField!
    @IBOutlet var expireDateTextField: UITextField!
    @IBOutlet var cvcTextField: UITextField!
    @IBOutlet var amountTextField: UITextField!
    @IBAction func Pay(_ sender: Any) {
        
        
        
        let cardParams = STPCardParams()
        cardParams.number = cardNumberTextField.text
        let expirationDate = expireDateTextField.text?.components(separatedBy: "/")
            cardParams.expMonth = UInt((expirationDate?[0])!)!
            cardParams.expYear  = UInt((expirationDate?[1])!)!
            cardParams.cvc = cvcTextField.text
        if STPCardValidator.validationState(forCard: cardParams) == .invalid {
            
            return
            
        }
        
        STPAPIClient.shared().createToken(withCard: cardParams, completion: { (token, error) in
            
            if error != nil{
                
                self.handleError(error: error! as NSError)
                return
                
                
            }
            
            postStripeToken(token: token!)
            
            
        })
        
        
        func postStripeToken(token:STPToken){
            
           // let URL = "http://localhost/donate/payment.php"
            //let URL = "http://ec2-54-206-38-168.ap-southeast-2.compute.amazonaws.com/donate/payment.php"
            
            let URL = "http://ec2-54-245-158-23.us-west-2.compute.amazonaws.com/donate/payment.php"
            let params = ["stripeToken": token.tokenId,
                          "amount": Int(amountTextField.text!),
                          "currency": "aud",
                          "description": self.emailTextField.text] as [String : Any]
            
            print(amountTextField.text)
            print(cardNumberTextField.text)
            print(cvcTextField.text)
            print(emailTextField.text)
            print(expireDateTextField.text)
            let manager = AFHTTPSessionManager()
            manager.responseSerializer = AFHTTPResponseSerializer()
            
            
            
           manager.post(URL, parameters: params, success: { (operation,responseObject) in
            if let response = responseObject as? [String: String] {
                UIAlertView(title: response["status"],
                            message: response["message"],
                            delegate: nil,
                            cancelButtonTitle: "OK").show()
            }
           },failure: {
            
            (operation, error) in
            print(error	)
           })
            
            
        }
        
        
        
        
        
        
    }
        
        
        
        func handleError(error: NSError) {
            UIAlertView(title: "Please Try Again",
                        message: error.localizedDescription,
                        delegate: nil,
                        cancelButtonTitle: "OK").show()
            
        }
        
        
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
