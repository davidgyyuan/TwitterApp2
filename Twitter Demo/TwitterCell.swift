//
//  TwitterCell.swift
//  Twitter Demo
//
//  Created by David Yuan on 2/26/17.
//  Copyright © 2017 David Yuan. All rights reserved.
//

import UIKit

class TwitterCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var name2Label: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contentText: UILabel!
    @IBOutlet weak var imagebutton: UIButton!
    
    @IBOutlet weak var statusButton: UIButton!
    @IBOutlet weak var flabel: UILabel!
    @IBOutlet weak var rlabel: UILabel!
    @IBOutlet weak var rImage: UIButton!
    @IBOutlet weak var fImge: UIButton!
    let tap = UITapGestureRecognizer()
    override func awakeFromNib() {
        super.awakeFromNib()
        tap.addTarget(self, action: #selector(TwitterCell.tappedView))
        profileImage.addGestureRecognizer(tap)
    }
    func tappedView(){
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
