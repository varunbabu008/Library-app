//
//  AboutViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Varun Babu on 8/6/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

 
    @IBOutlet var stripelabel: UILabel!
    @IBOutlet var parseServerLabel: UILabel!
    @IBOutlet var tableViewAnimation: UILabel!
    @IBOutlet var spinnerLabel: UILabel!
    @IBOutlet var FacebookLoginLable: UILabel!
    @IBOutlet var uberRidesLabel: UILabel!
    @IBOutlet var awsLabel: UILabel!
    @IBOutlet var mongoDBLabel: UILabel!
    @IBOutlet var XamppLabel: UILabel!
    
    @IBAction func XampLabel(_ sender: Any) {
        
        if let url = NSURL(string: "http://www.9lessons.info/2015/12/amazon-ec2-setup-with-ubuntu-and-xampp.html") {
            UIApplication.shared.openURL(url as URL)
        }
        
    }
    
    
    @IBAction func mongoDBURL(_ sender: Any) {
        
        if let url = NSURL(string: "https://docs.mongodb.com/manual/") {
            UIApplication.shared.openURL(url as URL)
        }
        
        
    }
    @IBAction func awsURL(_ sender: Any) {
        
        if let url = NSURL(string: "http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/launching-instance.html") {
            UIApplication.shared.openURL(url as URL)
        }
        
    }
    @IBAction func uberRidesURL(_ sender: Any) {
        
        
        if let url = NSURL(string: "https://github.com/uber/rides-ios-sdk") {
            UIApplication.shared.openURL(url as URL)
        }
        
    }
    @IBAction func FacebookLoginURL(_ sender: Any) {
        
        if let url = NSURL(string: "https://github.com/parse-community/ParseUI-iOS/wiki/Integrate-Login-with-Facebook") {
            UIApplication.shared.openURL(url as URL)
        }
        
    }
    @IBAction func ParseURL(_ sender: Any) {
        
        if let url = NSURL(string: "http://parseplatform.org/Parse-SDK-iOS-OSX/api/") {
            UIApplication.shared.openURL(url as URL)
        }
        
    }
    @IBAction func stripeurl(_ sender: Any) {
        
        if let url = NSURL(string: "https://stripe.com/docs") {
            UIApplication.shared.openURL(url as URL)
        }
    }
    
    @IBAction func tableViewAnimationURL(_ sender: Any) {
        
        if let url = NSURL(string: "https://github.com/ioramashvili/TableViewReloadAnimation") {
            UIApplication.shared.openURL(url as URL)
        }
        
    }

    @IBAction func spinnerURL(_ sender: Any) {
        
        if let url = NSURL(string: "https://github.com/goktugyil/EZLoadingActivity") {
            UIApplication.shared.openURL(url as URL)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        stripelabel.text = "• Payment Gateway"
        parseServerLabel.text = "• Parse Server"
        tableViewAnimation.text = "• TableView Animation"
        spinnerLabel.text = "• Activity Spinner"
        FacebookLoginLable.text = "• Facebook Login"
        uberRidesLabel.text = "• Uber Rides SDK"
        awsLabel.text = "• AWS Hosting"
        mongoDBLabel.text = "• Mongo DB"
        XamppLabel.text = "• Xampp server" 
        
        
        
   
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
