//
//  StatusViewController.swift
//  Twitter Demo
//
//  Created by David Yuan on 3/4/17.
//  Copyright © 2017 David Yuan. All rights reserved.
//

import UIKit

class StatusViewController: UIViewController {
    var status: Tweet?
    var user: Users?
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var name2Label: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var rImage: UIButton!
    
    @IBOutlet weak var rLabel: UILabel!
    @IBOutlet weak var fImge: UIButton!
    
    @IBOutlet weak var fLabel: UILabel!
    
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func replyButton(_ sender: Any) {
        performSegue(withIdentifier: "compose2", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="compose2" {
            let vc = segue.destination as! ComposeViewController
            vc.replyID = status?.id
            vc.replyUsername = status?.user?.screenname
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setThings()
    }
    @IBAction func fButton(_ sender: Any) {
        let tweet = status
        TwitterClient.sharedInstance?.post("1.1/favorites/create.json", parameters: ["id": tweet?.id], progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            // self.tableView.reloadData()
            //tweet.favorited = !tweet.favorited!
            // let cell = self.tableView.visibleCells[sender.tag] as! TwitterCell
            //cell.fImge.setImage(#imageLiteral(resourceName: "favoriteson"), for: UIControlState.normal)
            // self.tableView.reloadData()
            tweet?.favoritesCount+=1
        }, failure: { (task: URLSessionDataTask?, error:Error) in
            print(error.localizedDescription)
        })
        setThings()
        
    }
    func setThings(){
        let tweet = status
        contentLabel.text=tweet?.text!
        let time1 = Double((tweet?.timestamp?.timeIntervalSinceNow.description)!)
        
        timeLabel.text = String(Int(time1! * -1 / 60))
        timeLabel.text?.append("h")
        profileImage.setImageWith((tweet?.user?.profileURL)!)
        nameLabel.text=tweet?.user?.name
        name2Label.text="@\(tweet!.user!.screenname!)"
        profileImage.layer.cornerRadius = 5
        profileImage.clipsToBounds = true
        super.viewDidLoad()
        rImage.setImage(tweet?.rimage, for: UIControlState.normal)
        fImge.setImage(tweet?.fimage, for: UIControlState.normal)
        fLabel.text=String(describing: tweet!.numf)
        rLabel.text=String(describing: tweet!.numr)
    }
    
    @IBAction func rButton(_ sender: Any) {
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
