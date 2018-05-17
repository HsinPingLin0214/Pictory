//
//  LoginViewController.swift
//  Pictory
//
//  Created by Jenna on 17/5/18.
//  Copyright © 2018 Hsin-Ping Lin. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func loginButton(_ sender: Any) {
        if emailTextField.text != "" || passwordTextField.text != ""
        {
            Auth.auth().signInAnonymously(
                completion: {(user, error) in
                    if error != nil
                    {
                        print(error ?? "Error")
                        
                    }
                    return
            })
            self.performSegue(withIdentifier: "LoginSegue", sender: nil)
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
