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
    var pooImages = [PFFile]()
    var coordinates = [CLLocationCoordinate2D]()
    var markers = [GMSMarker]()
    
//    var mVC = MapViewController()
    
    func getLocation(mapView: GMSMapView){
    userLocation = mapView.camera.target
        print("userLocation updated")
    }
    
    
    func savePoo(location: String, description: String){
        if userLocation.latitude != 0 && userLocation.longitude != 0 {
    
            let pooMarker = PFObject(className: "PooMarker")
            let imageData = UIImagePNGRepresentation(currentPoo!)
            let imageFile = PFFile(data: imageData!)
    
            pooMarker["userid"] = PFUser.current()?.objectId!
            pooMarker["location"] = PFGeoPoint(latitude: userLocation.latitude, longitude: userLocation.longitude)
            pooMarker["pooImage"] = imageFile
            pooMarker["locationDescription"] = location
            pooMarker["descriptionDescription"] = description
    
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
                            pooMarkerMap.icon = self.imageWithImage(image: pooImageIcon, scaledToSize: CGSize(width: 40.0, height: 40.0))
                        }
                    }
                }
                markers.append(pooMarkerMap)
                i += 1
            }

    
        }
    
    }
    
    
 
 
    
    
    func displayAlert(title: String, message: String){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        let mapViewController: MapViewController = MapViewController(nibName: nil, bundle: nil)
 //       var value = myCustomViewController.someVariable

        
        mapViewController.present(alertController, animated: true, completion: nil)
    }
    
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        image.draw(in: CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: newSize.width, height: newSize.height)))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    
}
