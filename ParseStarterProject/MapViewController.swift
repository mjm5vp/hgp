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
    
 //   var infoWindow = CustomInfoView()
 //   var activePoint : POIItem?
    var userLocation = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    var brain = PooBrain()
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var toiletOutlet: UIButton!
    @IBAction func toiletFlush(_ sender: UIButton) {
    }
    @IBAction func refresh(_ sender: UIButton) {
        

//        print("after fillMap before loopCoordinate")
//        brain.loopCoordinates()
//        printStuff()
        print (brain.markers.count)

        
    //    fillMap()
    }
    


  /*
    var pooImages = [PFFile]()
    var coordinates = [CLLocationCoordinate2D]()
    var markers = [GMSMarker]()
   */
    

    
    

//    @IBOutlet weak var mapView: GMSMapView!
//    @IBOutlet weak var toiletOutlet: UIButton!
 //   @IBAction func toiletFlush(_ sender: UIButton)
   /*
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
            for marker in markers {
                marker.map = mapView
            }
        
        }
        
    }
 */
    
    
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

        
        pooPlacer.image = currentPoo
        pooPlacer.isHidden = true
        toiletOutlet.isHidden = true
        
        brain.getLocation(mapView: mapView)
        brain.fillMap(mapView: mapView, condition: "a")
        


        

        

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
        mapView.mapType = kGMSTypeHybrid
        
        
        let camera = GMSCameraPosition(target: userLocation, zoom: 15, bearing: 0, viewingAngle: 0)
        
        mapView.camera = camera
        
        manager.stopUpdatingLocation()
        
    }
/*
    func mapView(mapView: GMSMapView, didTapMarker marker: GMSMarker) -> Bool {
        if let poiItem = marker as? POIItem {
            // Remove previously opened window if any
            if activePoint != nil {
                infoWindow.removeFromSuperview()
                activePoint = nil
            }
            // Load custom view from nib or create it manually
            // loadFromNib here is a custom extension of CustomInfoView
            infoWindow = CustomInfoView.loadFromNib()
            // Button is here
            infoWindow.testButton.addTarget(self, action: #selector(self.testButtonPressed), forControlEvents: .AllTouchEvents)
            
            infoWindow.center = mapView.projection.pointForCoordinate(poiItem.position)
            activePoint = poiItem
            self.view.addSubview(infoWindow)
        }
        return false
    }

*/
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        userLocation = position.target
    }
    
     func displayAlert(title: String, message: String){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
/*
    override func loadView() {
        brain.getLocation(mapView: mapView)
        brain.fillMap()
        for marker in brain.markers {
            marker.map = mapView
        }
    }
*/

    

}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


