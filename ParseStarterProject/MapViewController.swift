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
    var manager = CLLocationManager()
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var toiletOutlet: UIButton!
    
    @IBAction func toiletFlush(_ sender: UIButton) {
        
    }
    @IBAction func refresh(_ sender: UIButton) {
        
    }
    @IBAction func pooSelectorButton(_ sender: UIBarButtonItem) {
        
    }
    
    @IBOutlet weak var pooPlacer: UIImageView!
    

 //   var currentPoo = UIImage(basic.png)

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        mapView.clear()
        self.mapView.delegate = self

        
        pooPlacer.image = currentPoo
        pooPlacer.isHidden = true
        toiletOutlet.isHidden = true
        
        brain.getLocation(mapView: mapView)
        brain.queryAndStore()
        brain.loopCoordinates(mapView: mapView)
        brain.placeMarkers(mapView: mapView)

        

        // Do any additional setup after loading the view.
    }

    
    @IBAction func unwindToMenu(segue: UIStoryboardSegue) {}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        

        
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)

        
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

    func mapView(_ mapView: GMSMapView!, markerInfoWindow marker: GMSMarker!) -> UIView! {
        // Get a reference for the custom overlay
        let index:Int! = Int(marker.accessibilityLabel!)
        let customInfoWindow = Bundle.main.loadNibNamed("InfoWindow", owner: self, options: nil)?[0] as! InfoWindow
        customInfoWindow.locationLabel.text = "test"
//        customInfoWindow.imageLabel.image = UIImage(named: "100")
        return customInfoWindow
    }
    
    func mapView(mapView: GMSMapView!, didTap marker: GMSMarker!) -> Bool {
        print("user tapped")
        return false
    }
 

    
     func displayAlert(title: String, message: String){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
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


