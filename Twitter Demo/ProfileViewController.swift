//
//  ViewController.swift
//  Twitter Demo
//
//  Created by David Yuan on 2/21/17.
//  Copyright © 2017 David Yuan. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    weak var delegate: ComposerDelegate?
    var user: Users?
    var status: Tweet?
    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var profileURL: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var desLabel: UILabel!
    @IBOutlet weak var erLabel: UILabel!
    @IBOutlet weak var ingLabel: UILabel!
    @IBOutlet weak var eetLabel: UILabel!
    override func viewDidLoad() {
        bannerImage.setImageWith((user?.bannerURL)!)
        profileURL.setImageWith((user?.profileURL)!)
        nameLabel.text = user?.name!
        desLabel.text = user?.tagline!
        erLabel.text = String(describing: user!.followers!)
        ingLabel.text = String(describing: user!.following!)
        eetLabel.text = String(describing: user!.tweets!)
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func returnTo(_ sender: Any) {
        delegate?.refreshTable()
        self.dismiss(animated: true, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   

}

