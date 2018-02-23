//
//  LoginViewController.swift
//  ParseExample
//
//  Created by Bethany Bin on 2/21/18.
//  Copyright © 2018 Bethany Bin. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBAction func loginButton(_ sender: Any) {
        checkFields()
        self.loginUser()
    }
    @IBAction func signupButton(_ sender: Any) {
        checkFields()
        registerUser()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordField.isSecureTextEntry = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func registerUser() {
        // initialize a user object
        let newUser = PFUser()
        
        // set user properties
        newUser.username = usernameField.text
        //newUser.email = emailLabel.text
        newUser.password = passwordField.text
        
        // call sign up function on the object
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
                self.presentError()
            } else {
                print("User Registered successfully")
                self.loginUser()
            }
        }
    }
    func loginUser() {
        
        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                print("User log in failed: \(error.localizedDescription)")
                self.presentError()
            } else {
                print("User logged in successfully")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }
    
    func checkFields(){
        if((usernameField.text?.isEmpty)! || (passwordField.text?.isEmpty)!){
            let alertController = UIAlertController(title: "Missing Field", message: "Please include both username and password", preferredStyle: .alert)
        
            // create an OK action
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                // handle response here.
            }
            // add the OK action to the alert controller
            alertController.addAction(OKAction)
            present(alertController, animated: true) {
                // optional code for what happens after the alert controller has finished presenting
            }
        }
    }
    
    func presentError(){
        let alertController = UIAlertController(title: "Error login/sign up", message: "Please try again", preferredStyle: .alert)
        
        // create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // handle response here.
        }
        // add the OK action to the alert controller
        alertController.addAction(OKAction)
        present(alertController, animated: true) {
            // optional code for what happens after the alert controller has finished presenting
        }
    }


}

