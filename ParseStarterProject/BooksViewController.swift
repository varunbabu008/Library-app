//
//  BooksViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Varun Babu on 4/5/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import Parse

class BooksViewController: UITableViewController,UISearchBarDelegate{
    
    @IBOutlet var searchBar: UISearchBar!
    
    //var requestBooks = [String]()
    var bookObjects = [PFObject]()
    
    var filteredBooks = [PFObject]()
    var searchActive:Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        getBooks()
        
        search()
        

        // Do any additional setup after loading the view.
    }
    
    func search(searchText:String? = nil){
        
        let query = PFQuery(className: "Books")
        if(searchText != nil){
            query.whereKey("Title", contains: searchText)
            
        }
        query.findObjectsInBackground { (results, error) in
            //self.filteredBooks = (results)!
            
            self.bookObjects = (results)!
            self.tableView.reloadData()
        }
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        search(searchText:searchText)
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
                
                //self.requestBooks.removeAll()
                self.bookObjects.removeAll()
                
                for book in books{
                    
                    if let bookTitle = book["Title"] as? String{
                        
                        
                        //self.requestBooks.append(bookTitle)
                        self.bookObjects.append(book)
                        
                        
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
                    
                    //destination.Booktitle = requestBooks[row]
                    
                    destination.item = bookObjects[row]
                    destination.navigationItem.title = "Book Details"
                                        
                    
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
        return bookObjects.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        //cell.textLabel?.text = requestBooks[indexPath.row]
        
            
        cell.textLabel?.text = bookObjects[indexPath.row]["Title"] as? String
            
        
        
        return cell
    
    }
    
    
    
    
    
    
    
}
