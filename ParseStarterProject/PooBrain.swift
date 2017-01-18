//
//  PooBrain.swift
//  ParseStarterProject-Swift
//
//  Created by Mark Moeller on 1/18/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import Foundation
import CoreLocation
import GoogleMaps
import Parse


class PooBrain{
    
    var userLocation = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
    func getLocation(mapView: GMSMapView){
    userLocation = mapView.camera.target
    }
    
    
    func savePoo(){
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
            self.displayAlert(title: "Location not working", message: "Please try again")
        }
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
    
    func displayAlert(title: String, message: String){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        let mapViewController: MapViewController = MapViewController(nibName: nil, bundle: nil)
 //       var value = myCustomViewController.someVariable

        
        mapViewController.present(alertController, animated: true, completion: nil)
    }
    
    
}
