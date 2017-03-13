//
//  LogInViewController.swift
//  Instagram
//
//  Created by Wenn Huang on 3/6/17.
//  Copyright © 2017 Wenn Huang. All rights reserved.
//

import UIKit
import Parse

class LogInViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var userNameField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSignInButton(_ sender: Any) {
        PFUser.logInWithUsername(inBackground: userNameField.text!, password: passwordField.text!) { (user : PFUser?, error: Error?) in
            if (user != nil){
            print("works")
                self.performSegue(withIdentifier: "toviewcontroller", sender: nil)
            }
            else{
                print(error?.localizedDescription)
            }
        }
    }

    @IBAction func onSignUp(_ sender: UIButton) {
        let newUser = PFUser()
        
        newUser.email = emailField.text
        newUser.username = userNameField.text
        newUser.password = passwordField.text
        
        newUser.signUpInBackground { (success: Bool, error: Error?) -> Void in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("User Registered successfully")
                self.performSegue(withIdentifier: "toviewcontroller", sender: nil)
                // manually segue to logged in view
            }
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

}
