//
//  TweetViewController.swift
//  Twitter Demo
//
//  Created by David Yuan on 2/26/17.
//  Copyright © 2017 David Yuan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ComposerDelegate {
    var tweetslist: [Tweet]!
 
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
       TwitterClient.sharedInstance?.homeTimeline(success: { (tweets: [Tweet]) in
        self.tweetslist=tweets
       // print(tweets.count)
       // print(self.tweetslist.count)
        self.tableView.reloadData()

       // for tweet in tweets{
          //  self.tweetslist.append(tweet)
       // }
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        })
       // print(tweetslist.count)
               // Do any additional setup after loading the view.
       
        
    }
    public func refreshTable() {
    print("Prepare")
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: {
        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets: [Tweet]) in
            
            self.tweetslist=tweets
            // print(tweets.count)
            // print(self.tweetslist.count)
            self.tableView.reloadData()
            print("Table Refresh")
            // for tweet in tweets{
            //  self.tweetslist.append(tweet)
            // }
            
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        })
        })
    }
    @IBAction func profileButton(_ sender: Any) {
      userProfile = Users.currentUser
      
      performSegue(withIdentifier: "profile", sender: nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    @IBAction func favbutton(_ sender: UIButton) {
        let tweet = tweetslist[sender.tag]
       
        TwitterClient.sharedInstance?.post("1.1/favorites/create.json", parameters: ["id": tweet.id], progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
           // self.tableView.reloadData()
            //tweet.favorited = !tweet.favorited!
           // let cell = self.tableView.visibleCells[sender.tag] as! TwitterCell
            //cell.fImge.setImage(#imageLiteral(resourceName: "favoriteson"), for: UIControlState.normal)
           // self.tableView.reloadData()
            tweet.favoritesCount+=1
        }, failure: { (task: URLSessionDataTask?, error:Error) in
            print(error.localizedDescription)
        })
        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets: [Tweet]) in
            //tweet.numf+=1
            self.tweetslist=tweets
            // print(tweets.count)
            // print(self.tweetslist.count)
            self.tableView.reloadData()
            
            // for tweet in tweets{
            //  self.tweetslist.append(tweet)
            // }
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        })

        DispatchQueue.main.async{
           // tweet.numf+=1
            self.tableView.reloadData()
        }
    }
    
    @IBAction func composeButton(_ sender: Any) {
        performSegue(withIdentifier: "compose", sender: nil)
        
    }

    @IBAction func retButton(_ sender: UIButton) {
        let tweet = tweetslist[sender.tag]
        
        TwitterClient.sharedInstance?.post("1.1/statuses/retweet/:id.json", parameters: ["id": tweet.id], progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            // self.tableView.reloadData()
            //tweet.favorited = !tweet.favorited!
            // let cell = self.tableView.visibleCells[sender.tag] as! TwitterCell
            //cell.fImge.setImage(#imageLiteral(resourceName: "favoriteson"), for: UIControlState.normal)
            // self.tableView.reloadData()
        }, failure: { (task: URLSessionDataTask?, error:Error) in
            print(error.localizedDescription)
        })
        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets: [Tweet]) in
            self.tweetslist=tweets
            // print(tweets.count)
            // print(self.tweetslist.count)
            self.tableView.reloadData()
            
            // for tweet in tweets{
            //  self.tweetslist.append(tweet)
            // }
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        })
        
        DispatchQueue.main.async{
            self.tableView.reloadData()
        }
    }
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if self.tweetslist == nil{
           // print("nil")
            return 0
            
        }
        /* if searchController.isActive && searchController.searchBar.text != "" {
         return filteredbusinesses.count
         }*/
        print("not nil")
        return self.tweetslist.count
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "TwitterCell", for: indexPath) as! TwitterCell
        
        let tweet = self.tweetslist[indexPath.row]
       // print(tweet.text!)
        cell.contentText.text=tweet.text!
        let time1 = Double((tweet.timestamp?.timeIntervalSinceNow.description)!)
        
        cell.timeLabel.text = String(Int(time1! * -1 / 60))
          cell.timeLabel.text?.append("h")
        cell.profileImage.setImageWith((tweet.user?.profileURL)!)
        cell.nameLabel.text=tweet.user?.name
        cell.name2Label.text="@\(tweet.user!.screenname!)"
        cell.profileImage.layer.cornerRadius = 5
        cell.profileImage.clipsToBounds = true
        cell.imagebutton.tag = indexPath.row
        cell.rImage.setImage(tweet.rimage, for: UIControlState.normal)
        cell.fImge.setImage(tweet.fimage, for: UIControlState.normal)
        cell.rImage.tag=indexPath.row
        cell.fImge.tag=indexPath.row
        cell.flabel.text=String(tweet.numf)
        cell.rlabel.text=String(tweet.numr)
        cell.statusButton.tag=indexPath.row
        return cell
    }
    var userProfile : Users? = nil
    var statusProfile : Tweet? = nil
    @IBAction func imageButtonPress(_ sender: UIButton) {
        let count = sender.tag
        let tweet = self.tweetslist[count]
        userProfile = tweet.user
        performSegue(withIdentifier: "profile", sender: nil)
        
    }
  
    @IBAction func statusButtonPress(_ sender: UIButton) {
        let count = sender.tag
        let tweet = self.tweetslist[count]
        statusProfile = tweet
        performSegue(withIdentifier: "status", sender: nil)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "status" {
            let detailViewController = segue.destination as! StatusViewController
            detailViewController.user = userProfile
            detailViewController.status = statusProfile
        }
        if segue.identifier == "profile" {
            let detailViewController = segue.destination as! ProfileViewController
            detailViewController.user = userProfile
            detailViewController.status = statusProfile
            detailViewController.delegate = self
        }
        if segue.identifier == "compose" {
          let detailViewController = segue.destination as! ComposeViewController
            detailViewController.delegate=self
        }
    
        
    }
    

}
