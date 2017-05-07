//
//  HistoryViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Varun Babu on 7/5/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import Parse

class HistoryViewController: UIViewController,UITableViewDelegate {


    @IBOutlet var tableView: UITableView!
    var bookObjects = [PFObject]()
    var  bookISBNObjects = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getBorrowedBooks()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //getBorrowedBooks()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getBorrowedBooks(){
        
        let query = PFQuery(className: "Borrowers")
        query.whereKey("Username", equalTo: PFUser.current()!.username)
        query.findObjectsInBackground { (objects, error) in
            
            if let bookISBN = objects{
                
                self.bookISBNObjects.removeAll()
                
                for book in bookISBN{
                    
                    self.bookISBNObjects.append(book["ISBN"] as! String)
                    
                }
            }
        }
        
        let query1 = PFQuery(className: "Books")
        //query1.whereKey("ISBN", containedIn: bookISBNObjects)
        query1.whereKey("ISBN", equalTo: "1002")
        query1.findObjectsInBackground(block: { (objects, error) in
            
            if let books = objects{
                
                //self.requestBooks.removeAll()
                self.bookObjects.removeAll()
                
                for book in books{
                    
                    
                            self.bookObjects.append(book)
                        
                        
                
                    
                }
                
                self.tableView.reloadData()
                
                
            }
            
        })
    }
    
   func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return bookObjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        //cell.textLabel?.text = requestBooks[indexPath.row]
        
        
        cell.textLabel?.text = bookObjects[indexPath.row]["Title"] as? String
        
        
        
        return cell
        
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
