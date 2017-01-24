//
//  TableViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Mark Moeller on 1/16/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Parse
import GoogleMaps


class TableViewController: UITableViewController {
    
    var brain = PooBrain()
 //   var MVC = MapViewController()
 //   var markersCount = 0
    
    var userLocation = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    var pooImages = [PFFile]()
    var pooImagesUI = [UIImage]()
    var coordinates = [CLLocationCoordinate2D]()
    var locations = [String]()
    var descriptions = [String]()
    var markers = [GMSMarker]()
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        brain.fillMapB()
 //       brain.fillMap()
        print(brain.markers.count)
//        markersCount = brain.markers.count

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
           
            let query = PFQuery(className: "PooMarker")
            print(query)
            
            pooImages.removeAll()
            coordinates.removeAll()
            locations.removeAll()
            descriptions.removeAll()
            pooImagesUI.removeAll()
            markers.removeAll()
            
            query.whereKey("userid", equalTo: (PFUser.current()?.objectId!)!)
            
            
            
            
            query.findObjectsInBackground(block: { (objects, error) in
                
                if error != nil {
                    
                    print("there was an error")
                    
                } else if let users = objects {
                    if let users = objects {
                        
                        print("if let users")
                        
                        
                        
                        
                        
                        for object in users {
                            print ("for object in users")
                            if let user = object as? PFObject {
                                print ("if let user")
                                
                                self.pooImages.append(user["pooImage"] as! PFFile)
                                self.coordinates.append(CLLocationCoordinate2D(latitude: (user["location"] as AnyObject).latitude, longitude: (user["location"] as AnyObject).longitude))
                                self.locations.append(user["locationDescription"] as! String)
                                self.descriptions.append(user["descriptionDescription"] as! String)
                                self.tableView.reloadData()
                                
                            }
                        }
                    }
                    
                }
                //      return "location is \(locations[0])"
            })
        }
        
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
 //       brain.printNumber()
        print ("coordinates count: \(coordinates.count)")
        return coordinates.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        cell.pooImage.image = pooImagesUI[indexPath.row]
        cell.descriptionLabel.text = descriptions[indexPath.row]
        
 //       print (cell.descriptionLabel.text)
        
        

        // Configure the cell...

        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
