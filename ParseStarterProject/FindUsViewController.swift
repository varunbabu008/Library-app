//
//  FindUsViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Varun Babu on 6/5/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import MapKit

class FindUsViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {

    @IBOutlet var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    
    var caulfieldLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: -37.8770, longitude: 145.0443)
    var claytonLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: -37.9150, longitude: 145.1300)
    var peninsulaLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: -38.1536, longitude: 145.1344)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
        
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        locationManager.requestWhenInUseAuthorization()
        
        
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true

    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = manager.location?.coordinate{
            
            let region = MKCoordinateRegion(center: claytonLocation, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
            
            self.mapView.setRegion(region, animated: true)
            
            self.mapView.removeAnnotations(self.mapView.annotations)
            
            self.mapView.showsUserLocation = true
            
            let annotationCaulfield = MKPointAnnotation()
            let annotationClayton = MKPointAnnotation()
            let annotationPeninsula = MKPointAnnotation()
            
            annotationCaulfield.coordinate = caulfieldLocation
            annotationClayton.coordinate = claytonLocation
            annotationPeninsula.coordinate = peninsulaLocation
            
            annotationCaulfield.title = "Caulfield"
            annotationClayton.title = "Clayton"
            annotationPeninsula.title = "Peninsula"
            
            var annotations = [MKPointAnnotation]()
            annotations.append(annotationCaulfield)
            annotations.append(annotationClayton)
            annotations.append(annotationPeninsula)
            
            mapView.addAnnotations(annotations)
            
            locationManager.stopUpdatingLocation()
            
            
            
            

            
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
