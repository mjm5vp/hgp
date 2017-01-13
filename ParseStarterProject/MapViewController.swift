//
//  MapViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Mark Moeller on 10/6/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Parse



class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate  {
    
    var userLocation = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    var pinAnnotationView:MKPinAnnotationView!

    @IBAction func toiletFlush(_ sender: AnyObject) {
        
        userLocation = mapView.centerCoordinate
        
        if userLocation.latitude != 0 && userLocation.longitude != 0 {
            let pooMarker = PFObject(className: "PooMarker")
        
            pooMarker["username"] = PFUser.current()?.username
            pooMarker["location"] = PFGeoPoint(latitude: userLocation.latitude, longitude: userLocation.longitude)
            pooMarker.saveInBackground(block: { (success, error) in
                if success {
                    print ("Poo Saved")
                    
                    
                } else {
                    self.displayAlert(title: "Failed to save", message: "Please try again")
                }
            })
            


            }
        else {
            self.displayAlert(title: "Failed to save", message: "Please try again")
        
        }
        let pointAnnotation = MKPointAnnotation()
        pointAnnotation.coordinate = userLocation
        pinAnnotationView = MKPinAnnotationView(annotation: pointAnnotation, reuseIdentifier: "pin")
        self.mapView.addAnnotation(pinAnnotationView.annotation!)
        /*
      var annotation = MKPointAnnotation()
        annotation.coordinate = userLocation
        annotation.
        self.mapView.addAnnotation(annotation)
        */
        

        
    }
    @IBAction func pooSelectorButton(_ sender: UIBarButtonItem) {
        

        
    }
    
    

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var pooPlacer: UIImageView!
    

 //   var currentPoo = UIImage(basic.png)
    var manager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
//        pooPlacer.image = currentPoo
        
//        pooPlacer.isHidden = true
 

        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func unwindToMenu(segue: UIStoryboardSegue) {}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        

        
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        
        let region = MKCoordinateRegion(center: userLocation, span: span)
        
        self.mapView.setRegion(region, animated: true)
        
        manager.stopUpdatingLocation()
        
    }
    
     func displayAlert(title: String, message: String){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func MapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        let annotationReuseId = "pin"
        var anView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationReuseId)
        if anView == nil {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationReuseId)
        } else {
            anView?.annotation = annotation
        }
        anView?.image = UIImage(named: "basic.png")
        anView?.canShowCallout = false
        return anView
    }
}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


