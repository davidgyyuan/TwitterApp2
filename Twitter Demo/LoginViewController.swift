//
//  LoginViewController.swift
//  Twitter Demo
//
//  Created by David Yuan on 2/21/17.
//  Copyright © 2017 David Yuan. All rights reserved.
//

import UIKit
import BDBOAuth1Manager
class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("start")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onLoginButton(_ sender: Any) {
        //let twitterClient = BDBOAuth1SessionManager(baseURL: URL(string: "https://api.twitter.com")!, consumerKey: "vdqohgK10iC8k7HDtVXgu1bKk", consumerSecret: "Pk6Ifm0hzXaYCd2WSKGRI5bCT76WImtpbIop4195HQ5NXvILwt")!
        let client = TwitterClient.sharedInstance!
        client.login(success: { () -> () in
            print("logged")
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
        }) { (error: Error) -> () in
            print("Error: \(error.localizedDescription)")
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
