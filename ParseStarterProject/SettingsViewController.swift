//
//  SettingsViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Mark Moeller on 2/23/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Parse

class SettingsViewController: UIViewController {

    @IBAction func logoutButton(_ sender: UIButton) {
 //       self.navigationController?.popViewController(animated: true)
        
        PFUser.logOut()
        let currentUser = PFUser.current()
        if currentUser == nil {
            self.navigationController?.isNavigationBarHidden = true
            performSegue(withIdentifier: "toLoginSegue", sender: self)
            print("user logged out")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
