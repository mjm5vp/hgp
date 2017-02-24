//
//  LoginViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Mark Moeller on 1/7/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import Parse
import GoogleMaps
import FBSDKLoginKit



class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    let loginButton : FBSDKLoginButton = FBSDKLoginButton()
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    var signUpMode = false
    var fbLoginSucess = false
    
    
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
                            self.performSegue(withIdentifier: "toMenuSegue", sender: self)

                            print("Sign Up Successful")
                        }
                    })
                }
                    
                
                
            } else {
                
                // Login mode
                
                PFUser.logInWithUsername(inBackground: usernameTextField.text!, password: passwordTextField.text!, block: { (user, error) in
                    
// spinner?         self.activityIndicator.stopAnimating()
                    
                    UIApplication.shared.endIgnoringInteractionEvents() // UIApplication.shared() is now UIApplication.shared
                    
                    
                    if error != nil {
                        
                        var displayErrorMessage = "Please try again later."
                        
                        let error = error as NSError?
                        
                        if let errorMessage = error?.userInfo["error"] as? String {
                            
                            displayErrorMessage = errorMessage
                            
                        }
                        
                        self.displayAlert(title: "Login Error", message: displayErrorMessage)
                        
                        
                    } else {
                        
                        print("Logged in")
                        
                        self.performSegue(withIdentifier: "toMenuSegue", sender: self)
                        
                    }
                    
                    
                })
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
        
        FBSDKLoginManager().logOut()

        
        if (FBSDKAccessToken.current() != nil)
        {
            
           performSegue(withIdentifier: "toMenuSegue", sender: self)
            
            print("Facebook Logged In")
            
        }
        else
        {
            
            
            loginButton.center = self.view.center
            
            loginButton.readPermissions = ["public_profile", "email"]
            
            loginButton.delegate = self
            
            self.view.addSubview(loginButton)
        }

        // Do any additional setup after loading the view.
    }
    

    
    /////FACEBOOK
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        if error != nil
        {
            
            print(error)
            
        }
        else if result.isCancelled {
            
            print("User cancelled login")
            
        }
        else {
            
            
            if result.grantedPermissions.contains("email")
            {
                
                if let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"email,name"]) {
                    
                    graphRequest.start(completionHandler: { (connection, result, error) in
                        
                        if error != nil {
                            
                            print(error)
                            
                        } else {
                            
                            self.fbLoginSucess = true
                            self.performSegue(withIdentifier: "toMenuSegue", sender: self)
                            
                            if let userDetails = result as? [String: String] {

                                
                                print(userDetails["email"])
                                
                            }
                            
                        }
                        
                        
                    })
                    
                    
                }
                
                
                
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
        print("Logged out")
        
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
