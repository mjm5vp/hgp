//
//  LoginViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Mark Moeller on 1/7/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import Parse


class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    var signUpMode = false
    
    
    @IBOutlet weak var loginOrSignUpButton: UIButton!
    @IBOutlet weak var switchButton: UIButton!
    @IBAction func loginButton(_ sender: UIButton!) {
        
        if usernameTextField.text == "" || passwordTextField.text == "" {
            displayAlert(title: "Error in form", message: "Username and Password are required")
        } else {
            if signUpMode {
                if passwordTextField.text != confirmPassword.text {
                    displayAlert(title: "Error in form", message: "Password fields do not match")
                } else {
                    let user = PFUser()
                    user.username = usernameTextField.text
                    user.password = passwordTextField.text
                    user.signUpInBackground(block: { (success, error) in
                        if let error = error {
                            var displayedErrorMessage = "Please try again later"
                            if let parseError = (error as NSError).userInfo["error"] as? String {
                                displayedErrorMessage = parseError
                            }
                        
                        self.displayAlert(title: "Sign Up Failed", message: displayedErrorMessage)
                        }
                        else {
                            print("Sign Up Successful")
                        }
                    })
                }
                
            }
        }
       
            
        
    }
    
    @IBAction func switchButton(_ sender: UIButton!) {
        
        if signUpMode {
            loginOrSignUpButton.setTitle("Log In", for: [])
            switchButton.setTitle("Switch to Sign Up", for: [])
            signUpMode = false
            confirmPassword.isHidden = true
            
        }
        else {
            loginOrSignUpButton.setTitle("Sign Up", for: [])
            switchButton.setTitle("Switch to Log In", for: [])
            signUpMode = true
            confirmPassword.isHidden = false
        }
            
    
        
    }

    
    
    func displayAlert(title: String, message: String){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     confirmPassword.isHidden = true

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
