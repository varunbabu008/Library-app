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
    
    var item: PFObject?
    
    @IBOutlet var imageView: UIView!
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var ISBNTextField: UITextField!
    @IBOutlet var authorTextField: UITextField!
    @IBOutlet var genreTextField: UITextField!
    @IBOutlet var locationTextField: UITextField!
    @IBAction func placeOnHold(_ sender: Any) {
        
        
        let query = PFQuery(className: "Books")
        
        query.whereKey("ISBN", equalTo: ISBNTextField.text)
        
        query.findObjectsInBackground { (results, error) in
            
            if let books  = results{
                
                for book in books{
                    
                    book["isRented"] = true as Bool
                    book.saveInBackground()
                }
                
                
            }
            
        }
        
        //adding an entry to borrowers class
        
        //let query1 = PFQuery(className: "Borrowers")
        var currentUser = PFUser.current()!.username
        //var username = currentUser?.username
        var borrow = PFObject(className:"Borrowers")
        borrow["Username"] = currentUser
        borrow["ISBN"] = ISBNTextField.text
        borrow.saveInBackground()
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //titleTextField.text = Booktitle
        
//        if let topItem = self.navigationController?.navigationBar.topItem{
//            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
//        }
        
        
        titleTextField.text = item?["Title"] as! String
        ISBNTextField.text = item?["ISBN"] as! String
        authorTextField.text = item?["Author"] as! String
        genreTextField.text = item?["Genre"] as! String
        locationTextField.text = item?["Location"] as! String
        var image = item?["Image"] as? PFFile
        
        
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
