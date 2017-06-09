//
//  BookDetailsViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Varun Babu on 4/5/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import Parse
import UberRides
import MapKit
import CoreLocation

class BookDetailsViewController: UIViewController,CLLocationManagerDelegate {
    var Booktitle = ""
    
    var item: PFObject?
    
   
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var ISBNTextField: UITextField!
    @IBOutlet var authorTextField: UITextField!
    @IBOutlet var genreTextField: UITextField!
    @IBOutlet var locationTextField: UITextField!
    
    
    
    
    //Uber Rides
    let ridesClient = RidesClient()
    let button = RideRequestButton()
    
    var caulfield = CLLocation(latitude:-37.8770 , longitude:145.0443)
    var clayton = CLLocation(latitude: -37.9150 , longitude:145.1300)
    var peninsula = CLLocation(latitude:-38.1536 , longitude:145.1344)
    var userCurrentLocation = CLLocation()
    
    var pickupLocation = CLLocation()
    
    var locationManager:CLLocationManager!
    //var userLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    //var userLocation:CLLocation = CLLocation()
    @IBAction func placeOnHold(_ sender: Any) {
        
        
        let alertcontroller = UIAlertController(title: "Confirmation", message: "Are you sure you wanna borrow this book", preferredStyle: .alert)
        
        alertcontroller.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in
            //login unsuccesful if the message us not "Login Successful"
           
            let query = PFQuery(className: "Books")
            
            query.whereKey("ISBN", equalTo: self.ISBNTextField.text)
            
            query.findObjectsInBackground { (results, error) in
                
                if let books  = results{
                    
                    for book in books{
                        
                        book["isRented"] = true as Bool
                        book.saveInBackground()
                    }
                    
                    
                }
                
            }
            //Date
            let date = Date()
            var FourteenDaysfromNow: Date {
                return (Calendar.current as NSCalendar).date(byAdding: .day, value: 14, to: Date(), options: [])!
            }
            //adding an entry to borrowers class
            
            //let query1 = PFQuery(className: "Borrowers")
            var currentUser = PFUser.current()!.username
            //var username = currentUser?.username
            var borrow = PFObject(className:"Borrowers")
            borrow["Username"] = currentUser
            borrow["ISBN"] = self.ISBNTextField.text
            borrow["BorrowedDate"] = date
            borrow["DueDate"] = FourteenDaysfromNow
            borrow.saveInBackground()
            
        }))
        
        alertcontroller.addAction(UIAlertAction(title: "Cancel", style: .default, handler: {_ in
            //login unsuccesful if the message us not "Login Successful"
            return
            
        }))
        
        
        
        self.present(alertcontroller, animated: true, completion: nil)
        
        
        
    }
    
    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            //locationManager.startUpdatingHeading()
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
         userCurrentLocation = locations[0] as CLLocation
        
         //userCurrentLocation = manager.location!.coordinate
        // Call stopUpdatingLocation() to stop listening for location updates,
        // other wise this function will be called every time when user location changes.
        
        // manager.stopUpdatingLocation()
        
//        print("user latitude = \(userCurrentLocation.coordinate.latitude)")
//        print("user longitude = \(userCurrentLocation.coordinate.longitude)")
        
        
        pickupLocation = userCurrentLocation
        print(pickupLocation)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
    
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextField.text = item?["Title"] as! String
        ISBNTextField.text = item?["ISBN"] as! String
        authorTextField.text = item?["Author"] as! String
        genreTextField.text = item?["Genre"] as! String
        locationTextField.text = item?["Location"] as! String
        var image = item?["Image"] as? PFFile
        image?.getDataInBackground(block: { (result, error) in
            self.imageView.image = UIImage(data: result!)
        })
        
        
        determineMyCurrentLocation()
        self.hideKeyboardWhenTappedAround()
        
        
        
        UberRides()
      
        
    }
    
    // Using uber rides api to redirect the user to the uber app. Uber app must be installed
    func UberRides(){
        
        let pickupLocation = CLLocation(latitude: 37.775159, longitude: -122.417907)
        
        //getting the current users location for pickup
        //let pickupLocation = CLLocation(latitude:userCurrentLocation.latitude , longitude: userCurrentLocation.longitude)
        
        print("user latitude = \(userCurrentLocation.coordinate.latitude)")
        print("user longitude = \(userCurrentLocation.coordinate.longitude)")
        
        //let pickupLocation = userCurrentLocation
        //pickupLocation = userCurrentLocation
        print(pickupLocation)
        
        var dropoffLocation:CLLocation = CLLocation()
        if (locationTextField.text?.hasPrefix("Pen"))!{
            dropoffLocation = peninsula
        }
        print(locationTextField.text!)
        if (locationTextField.text?.hasPrefix("Cau"))!{
            dropoffLocation = caulfield
        }
        if (locationTextField.text?.hasPrefix("Cla"))!{
            dropoffLocation = clayton
        }
        
        //let dropoffLocation = CLLocation(latitude: 37.6213129, longitude: -122.3789554)
        let builder = RideParametersBuilder().setPickupLocation(pickupLocation).setDropoffLocation(dropoffLocation,nickname:"Library")
        ridesClient.fetchCheapestProduct(pickupLocation: pickupLocation, completion: {
            product, response in
            if let productID = product?.productID { //check if the productID exists
                builder.setProductID(productID)
                self.button.rideParameters = builder.build()
                
                // show estimates in the button
                self.button.loadRideInformation()
            }
        })
        
        
        button.center = view.center
        
        button.frame = CGRectMake(55, 570, 270, 40)
        
        view.addSubview(button)

        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
