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
import GoogleMaps



class MapViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate  {
    
    @IBAction func refresh(_ sender: UIButton) {
        fillMap()
    }
    var userLocation = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    var pinAnnotationView:MKPinAnnotationView!
    
    var pooImages = [PFFile]()
    var coordinates = [CLLocationCoordinate2D]()
    var markers = [GMSMarker]()

    
    

    @IBOutlet weak var mapView: GMSMapView!
    @IBAction func toiletFlush(_ sender: AnyObject) {
        
        userLocation = mapView.camera.target
        
        
        
        
        if userLocation.latitude != 0 && userLocation.longitude != 0 {
            let pooMarker = PFObject(className: "PooMarker")
            let imageData = UIImagePNGRepresentation(currentPoo!)
            let imageFile = PFFile(data: imageData!)
            
        
            pooMarker["userid"] = PFUser.current()?.objectId!
            pooMarker["location"] = PFGeoPoint(latitude: userLocation.latitude, longitude: userLocation.longitude)
            pooMarker["pooImage"] = imageFile
            pooMarker.saveInBackground(block: { (success, error) in
                if success {
                    print ("Poo Saved")
                    
                    
                } else {
                    self.displayAlert(title: "Failed to save", message: "Please try again")
                }
            })
            


            }
        else {
            self.displayAlert(title: "Location at zero", message: "Please try again")
        
        }
        
       
    /*
        let pooImage = GMSMarker(position: userLocation)
    //    pooImage.position = userLocation
    //    pooImage.icon = pooPlacer.image
        pooImage.icon = self.imageWithImage(image: pooPlacer.image!, scaledToSize: CGSize(width: 25.0, height: 25.0))
        pooImage.map = mapView
  //      self.mapView.addAnnotation(pinAnnotationView.annotation!)
        /*
      var annotation = MKPointAnnotation()
        annotation.coordinate = userLocation
        annotation.
        self.mapView.addAnnotation(annotation)
        */
        
    */
        
    }
    
    func fillMap(){
        var i = 0
        let query = PFQuery(className: "PooMarker")
        
        query.whereKey("userid", equalTo: (PFUser.current()?.objectId!)!)
        
        query.findObjectsInBackground(block: { (objects, error) in
            
            if error != nil {
                
                print(error)
                
            } else if let users = objects {
                
                self.pooImages.removeAll()
                self.coordinates.removeAll()
                
                for object in users {
                    if let user = object as? PFObject {
                        
                        self.pooImages.append(user["pooImage"] as! PFFile)
                        self.coordinates.append(CLLocationCoordinate2D(latitude: (user["location"] as AnyObject).latitude, longitude: (user["location"] as AnyObject).longitude))
                        
                            
                        }
                    }
                }
                
                
            })
        if coordinates.count > 0 {
            
            for coordinate in coordinates {
                let pooMarkerMap = GMSMarker(position: coordinate)
                pooImages[i].getDataInBackground { (data, error) in
                    if let imageData = data {
                        if let pooImageIcon = UIImage(data: imageData){
                            pooMarkerMap.icon = self.imageWithImage(image: pooImageIcon, scaledToSize: CGSize(width: 25.0, height: 25.0))
                        }
                    }
                
                
                 
                    
                   
                }
                markers.append(pooMarkerMap)
                i += 1
                
                
            
            }
            for marker in markers {
                marker.map = mapView
            }
        
        }
        
    }
    
    
    @IBAction func pooSelectorButton(_ sender: UIBarButtonItem) {
        

        
    }
    
    

 
    @IBOutlet weak var pooPlacer: UIImageView!
    

 //   var currentPoo = UIImage(basic.png)
    var manager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
      //  fillMap()
        
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
        
   //     print("location updated")
        
   //     let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = false
        
        
        let camera = GMSCameraPosition(target: userLocation, zoom: 15, bearing: 0, viewingAngle: 0)
        
        mapView.camera = camera
        
        manager.stopUpdatingLocation()
        
    }
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        userLocation = position.target
    }
    
     func displayAlert(title: String, message: String){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        image.draw(in: CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: newSize.width, height: newSize.height)))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
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


