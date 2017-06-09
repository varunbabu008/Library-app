//
//  HistoryViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Varun Babu on 7/5/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import Parse
import TableViewReloadAnimation
import EZLoadingActivity

class HistoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {


    @IBOutlet var tableView: UITableView!
    var bookObjects = [PFObject]()
    var  bookISBNObjects = [String](){
        // using didSet because asynchronous query
        didSet{
            
            let query1 = PFQuery(className: "Books")
            query1.whereKey("ISBN", containedIn: bookISBNObjects)
            
            query1.findObjectsInBackground(block: { (objects, error) in
                
                if let books = objects{
                    
                   
                    self.bookObjects.removeAll()
                    
                    for book in books{
                        
                        
                        self.bookObjects.append(book)
                        
                        
                    }
                    
                    self.tableView.reloadData( with: .spring(duration: 0.45, damping: 0.65, velocity: 1, direction: .right(useCellsFrame: false),
                                                             constantDelay: 0))
                    
                    
                }
                
            })
            

            
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        EZLoadingActivity.showWithDelay("Loading...", disableUI: false, seconds: 0.5)
        // shows history of previous books
        getBorrowedISBN()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func getBorrowedISBN(){
        
        let query = PFQuery(className: "Borrowers")
        query.whereKey("Username", equalTo: PFUser.current()!.username)
        query.findObjectsInBackground { (objects, error) in
            
            if let bookISBN = objects{
                
                self.bookISBNObjects.removeAll()
                
                for book in bookISBN{
                    
                    self.bookISBNObjects.append(book["ISBN"] as! String)
                    print("Array: \(self.bookISBNObjects)")
                    
                }
            }
        }
       
    }
    
    
    
   func numberOfSections(in tableView: UITableView) -> Int {
    
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return bookObjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        
        cell.textLabel?.text = bookObjects[indexPath.row]["Title"] as? String
        
        var PFImage = bookObjects[indexPath.row]["Image"] as? PFFile
        
        PFImage?.getDataInBackground(block: { (result, error) in
            cell.imageView?.image = UIImage(data: result!)
            
        })

        
        return cell
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "BookHistoryDetails" {
            
            if let destination = segue.destination as? BookHistoryDetailsViewController{
                
                if let row = tableView.indexPathForSelectedRow?.row{
                    
                    //destination.Booktitle = requestBooks[row]
                    
                    destination.item = bookObjects[row]
                    destination.navigationItem.title = "Book Histroy Details"
                    
                    
                }
            }
            
        }
        
    }


}
