//
//  ComposeViewController.swift
//  Twitter Demo
//
//  Created by David Yuan on 3/5/17.
//  Copyright © 2017 David Yuan. All rights reserved.
//

import UIKit
protocol ComposerDelegate: class {
    func refreshTable()
}
class ComposeViewController: UIViewController {
    weak var delegate: ComposerDelegate?
    @IBOutlet weak var textField: UITextView!
    var replyID: CLongLong?
    var replyUsername: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let replyUsername=replyUsername {
            textField.text = "@" + replyUsername
            
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ret(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    @IBAction func submitButton(_ sender: Any) {
        if let replyID = replyID{
            TwitterClient.sharedInstance?.post("1.1/statuses/update.json", parameters: ["status": textField.text, "in_reply_to_status_id": replyID], progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            }, failure: { (task: URLSessionDataTask?, error:Error) in
                print(error.localizedDescription)
            })
        }
        else{
            TwitterClient.sharedInstance?.post("1.1/statuses/update.json", parameters: ["status": textField.text], progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            }, failure: { (task: URLSessionDataTask?, error:Error) in
                print(error.localizedDescription)
            })
        }
         self.delegate?.refreshTable()
        self.dismiss(animated: true, completion: nil)
            
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
