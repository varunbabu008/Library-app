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
import Parse

class PaymentsViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var cardNumberTextField: UITextField!
    @IBOutlet var expireDateTextField: UITextField!
    @IBOutlet var cvcTextField: UITextField!
    @IBOutlet var amountTextField: UITextField!
    @IBOutlet var fineAmt: UILabel!
    
    
    // When Pay button Tapped
    @IBAction func Pay(_ sender: Any) {
        
        
        
        let cardParams = STPCardParams()
        cardParams.number = cardNumberTextField.text
        let expirationDate = expireDateTextField.text?.components(separatedBy: "/")
            cardParams.expMonth = UInt((expirationDate?[0])!)!
            cardParams.expYear  = UInt((expirationDate?[1])!)!
            cardParams.cvc = cvcTextField.text
        if STPCardValidator.validationState(forCard: cardParams) == .invalid {
            
            //return
            UIAlertView(title: "Invalid Card", message: "Try a different card", delegate: nil, cancelButtonTitle: "OK").show()
            return
        }
        
        
        //Connects to Stripe sertver and gets the token 
        
        STPAPIClient.shared().createToken(withCard: cardParams, completion: { (token, error) in
            
            if error != nil{
                
                self.handleError(error: error! as NSError)
                return
                
                
            }
            
            postStripeToken(token: token!)
            
            
        })
        
        
        // sends the Form parameters to the PHP Remote server for processing. The Card is charged here
        func postStripeToken(token:STPToken){
            
            // LocalHost url
            // let URL = "http://localhost/donate/payment.php"
            
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
            //manager.responseSerializer = AFHTTPResponseSerializer()
            
            
            // POST Request to PHP server
           manager.post(URL, parameters: params,progress: nil, success: { (operation,responseObject) in
            //print(responseObject)
            print(operation)
            if let response = responseObject as? [String: String] {
                UIAlertView(title: response["status"],
                            message: response["message"],
                            delegate: nil,
                            cancelButtonTitle: "OK").show()
                print(response)
//                self.test = response
            }
            
           },failure: {
            
            (operation, error) in
            print(error)
            
            self.handleError(error: error as NSError)
            
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
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
        let date = Date()
        var amtToBePaid = 0
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let DateNow = formatter.string(from: date)
        let query = PFQuery(className: "Borrowers")
        query.whereKey("Username", equalTo: PFUser.current()!.username)
        query.findObjectsInBackground { (results, error) in
            
            if let borrowers = results{
                
                for borrower in borrowers{
                    
                    if let borrowedDate = borrower["BorrowedDate"] as? Date{
                        
                        let borrowD = formatter.string(from:borrowedDate)
                        print(borrowD)
                        var FourteenDaysfromNow: Date {
                            return (Calendar.current as NSCalendar).date(byAdding: .day, value: 14, to: Date(), options: [])!
                        }
                        let dueD = formatter.string(from:FourteenDaysfromNow)
                        
                        print(dueD)
                        
                        let days: Int = self.calculateDaysBetweenTwoDates(start: borrowedDate, end: date)
                        print(days)
                        if(days > 14){
                            let multiplier = days - 14
                            amtToBePaid += 10 * multiplier
                            self.amountTextField.text = String(amtToBePaid)
                            self.fineAmt.text = "You have overdue Books in posession and the amount to be paid is \(amtToBePaid)$. Please check your History to view books"
                            
                        }
                        
                    }
                    
                }
                
                
                
            }
            
            
        }
        
        
        
    }
    
    // Returns the difference between two days
    private func calculateDaysBetweenTwoDates(start: Date, end: Date) -> Int {
        
        let currentCalendar = Calendar.current
        guard let start = currentCalendar.ordinality(of: .day, in: .era, for: start) else {
            return 0
        }
        guard let end = currentCalendar.ordinality(of: .day, in: .era, for: end) else {
            return 0
        }
        return end - start
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
