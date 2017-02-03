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
    @IBOutlet weak var infoView: UIView!
//    @IBOutlet weak var locationViewLabel: UILabel!
    
//    @IBOutlet weak var timeViewLabel: UILabel!
//    @IBOutlet weak var moreButton: UIButton!
    
    
    @IBAction func toiletFlush(_ sender: UIButton) {
        
    }
    
    @IBAction func pooSelectorButton(_ sender: UIBarButtonItem) {
        
    }
    
    @IBOutlet weak var pooPlacer: UIImageView!
    

 //   var currentPoo = UIImage(basic.png)

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBAction func addButton(_ sender: Any) {
    }
    
    @IBAction func editButton(_ sender: Any) {
    }


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        mapView.clear()
        mapView.delegate = self

        
        pooPlacer.image = currentPoo
        pooPlacer.isHidden = true
        toiletOutlet.isHidden = true
        infoView.isHidden = false
        
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
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        infoView.isHidden = false
        return false
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
//    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
//        userLocation = position.target
//    }
/*
    func mapView(_ mapView: GMSMapView!, markerInfoWindow marker: GMSMarker!) -> UIView! {
        // Get a reference for the custom overlay
        let index:Int! = Int(marker.accessibilityLabel!)
        let customInfoWindow = Bundle.main.loadNibNamed("InfoWindow", owner: self, options: nil)?[0] as! InfoWindow
        customInfoWindow.locationLabel.text = "test"
//        customInfoWindow.addButton(sender: )
//        customInfoWindow.imageLabel.image = UIImage(named: "100")
        return customInfoWindow
    }
*/
//    func mapView(mapView: GMSMapView!, didTap marker: GMSMarker!) -> Bool {
 //       print("user tapped")
 //       return false
 //   }
 

    
     func displayAlert(title: String, message: String){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
// MARKER INFO WINDOW
    // initialize and keep a marker and a custom infowindow
//    var tappedMarker = GMSMarker()
//    var infoWindow = Bundle.main.loadNibNamed("InfoWindow", owner: self, options: nil)?[0] as! InfoWindow
//
    
    //empty the default infowindow
//    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
//        return UIView()
//    }
    
    // reset custom infowindow whenever marker is tapped
//    func mapView(mapView: GMSMapView, didTapMarker: GMSMarker) -> Bool {
        
//        let infoWindow = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
//        print("tapped marker")
//        let location = CLLocationCoordinate2D(latitude: marker.position.latitude, longitude: marker.position.longitude)
//        let iW = InfoWindow()
        
//        tappedMarker = marker
//        infoWindow.removeFromSuperview()
//        infoWindow = mapMarkerInfoWindow(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
 //       infoWindow.Name.text = (marker.userData as! location).name
 //       infoWindow.Price.text = (marker.userData as! location).price.description
 //       infoWindow.Zone.text = (marker.userData as! location).zone.rawValue
 //       infoWindow.center = mapView.projection.point(for: location)
 //       infoWindow.
 //       self.mapView.addSubview(infoWindow)
        
        // Remember to return false
        // so marker event is still handled by delegate
 //       return true
//   }
/*
    // let the custom infowindow follows the camera
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        if (tappedMarker.userData != nil){
            let location = CLLocationCoordinate2D(latitude: tappedMarker.position.latitude, longitude: tappedMarker.position.longitude)
            infoWindow.center = mapView.projection.point(for: location)
        }
    }
*/
    // take care of the close event
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        infoView.isHidden = true
        print("tapped coordinate")
    }
 



    


    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}

