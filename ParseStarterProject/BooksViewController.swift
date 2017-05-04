//
//  BooksViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Varun Babu on 4/5/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import Parse

class BooksViewController: UITableViewController{
    
    
     var requestBooks = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getBooks()
        

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
    
    func getBooks(){
        
        let query = PFQuery(className: "Books")
        
        query.limit = 10
        
        query.findObjectsInBackground(block: { (objects, error) in
            
            if let books = objects{
                
                self.requestBooks.removeAll()
                
                for book in books{
                    
                    if let bookTitle = book["Title"] as? String{
                        
                        
                        self.requestBooks.append(bookTitle)
                        
                        
                    }
                    
                }
                
                self.tableView.reloadData()
                
                
            }
        
        })
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "bookDetails" {
            
            if let destination = segue.destination as? BookDetailsViewController{
                
                if let row = tableView.indexPathForSelectedRow?.row{
                    
                    destination.Booktitle = requestBooks[row]
                    
                    //destination.item =
                    
                    
                }
            }
            
        }

        
    }

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return requestBooks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = requestBooks[indexPath.row]
        
        return cell
    
    }
    
    
    
    
    
    
    
}
