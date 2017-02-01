//
//  FlushViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Mark Moeller on 1/18/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation


class FlushViewController: UIViewController {
    
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var pooImageField: UIImageView!
    

    
    
    var brain = PooBrain()
    
    

    
    @IBAction func flushButton(_ sender: Any) {
//        let changeMapViewController: MapViewController = MapViewController(nibName: nil, bundle: nil)
//        let mapView: GMSMapView = changeMapViewController.mapView
        
        
        self.performSegue(withIdentifier: "unwindToMenu", sender: self)
        

        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "unwindToMenu" {
            let destViewController: MapViewController = segue.destination as! MapViewController
            
            let mapView = destViewController.mapView
            let locationText = locationTextField.text
            let descriptionText = descriptionTextField.text
            let pooPlacer = destViewController.pooPlacer
            let toiletOutlet = destViewController.toiletOutlet

            
            brain.getLocation(mapView: mapView!)
            brain.savePoo(location: locationText!, description: descriptionText!)
            brain.queryAndStore()
            brain.loopCoordinates(mapView: mapView!)
            brain.placeMarkers(mapView: mapView!)
            
            pooPlacer?.isHidden = true
            toiletOutlet?.isHidden = true
            
            
            
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pooImageField.image = currentPoo

        // Do any additional setup after loading the view.
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
