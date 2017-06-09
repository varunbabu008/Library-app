//
//  BookHistoryDetailsViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Varun Babu on 21/5/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import Parse

class BookHistoryDetailsViewController: UIViewController {

    @IBOutlet var TitleTextField: UITextField!
    @IBOutlet var ISBNTextField: UITextField!
    @IBOutlet var authorTextField: UITextField!
    @IBOutlet var genreTextField: UITextField!
    @IBOutlet var locationTextField: UITextField!
    @IBOutlet var BorrowedDateTextField: UITextField!
    @IBOutlet var DueDateTextField: UITextField!
    var item: PFObject?
    override func viewDidLoad() {
        super.viewDidLoad()

        TitleTextField.text = item?["Title"] as! String
        ISBNTextField.text = item?["ISBN"] as! String
        authorTextField.text = item?["Author"] as! String
        genreTextField.text = item?["Genre"] as! String
        locationTextField.text = item?["Location"] as! String
        getDates()
    }
    
    //gets the borrowed and due dates of the borrowed book for the logged in user
    func getDates(){
        
        let query = PFQuery(className: "Borrowers")
        query.whereKey("ISBN", equalTo: ISBNTextField.text)
        query.whereKey("Username", equalTo: PFUser.current()!.username)
        
        query.findObjectsInBackground { (results, error) in
            if let objects = results{
                
                for object in objects{
                    
                    let formatter = DateFormatter()
                    formatter.dateFormat = "dd.MM.yyyy"
                    let DueDate = formatter.string(from: object["DueDate"] as! Date)
                    let BorrowedDate = formatter.string(from: object["BorrowedDate"] as! Date)
                    self.BorrowedDateTextField.text = BorrowedDate
                    self.DueDateTextField.text = DueDate
                    print(objects.count)
                    
                    
                }
                
                
            }
        }

        
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
