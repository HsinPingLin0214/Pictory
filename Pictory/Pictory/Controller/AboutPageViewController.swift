//
//  AboutPageViewController.swift
//  Pictory
//
//  Created by Jenna on 27/5/18.
//  Copyright © 2018 Hsin-Ping Lin. All rights reserved.
//

import UIKit
import Firebase

class AboutPageViewController: UIViewController {

    @IBAction func logOut(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        } catch {}
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
