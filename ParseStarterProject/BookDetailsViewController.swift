//
//  BookDetailsViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Varun Babu on 4/5/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import Parse

class BookDetailsViewController: UIViewController {
    var Booktitle = ""
    
    //var item = PFObject()
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var ISBNTextField: UITextField!
    @IBOutlet var authorTextField: UITextField!
    @IBOutlet var genreTextField: UITextField!
    @IBOutlet var locationTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        titleTextField.text = Booktitle
        
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
