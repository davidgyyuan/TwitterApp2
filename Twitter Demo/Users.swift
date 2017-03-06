//
//  Users.swift
//  Twitter Demo
//
//  Created by David Yuan on 2/24/17.
//  Copyright © 2017 David Yuan. All rights reserved.
//

import UIKit

class Users: NSObject {
    var name: String?
    var screenname: String?
    var profileURL: URL?
    var tagline: String?
    var bannerURL: URL?
    var followers: Int?
    var following: Int?
    var tweets: Int?
    var dictionary: NSDictionary?
    init(dictionary: NSDictionary) {
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        let burl = dictionary["profile_banner_url"] as? String
        if let burl = burl{
            bannerURL = URL(string: burl)
        }
       
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            profileURL = URL(string: profileUrlString)
        }
        tagline = dictionary["description"] as? String
        followers = dictionary["followers_count"] as? Int
        following = dictionary["friends_count"] as? Int
        tweets = dictionary["statuses_count"] as? Int
    }
    static var _currentUser: Users?
    class var currentUser: Users?{
        get{
           /* if _currentUser == nil{
                let defaults = UserDefaults.standard
                let userData = nil//defaults.object(forKey: "currentUserData") as? Data
                if let userData = userData{
                    
                        let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! NSDictionary
                        _currentUser = Users(dictionary: dictionary)
                    
                }
            }*/
            return _currentUser
        }

        set(user){
            _currentUser = user 
            let defaults = UserDefaults.standard
            defaults.removeObject(forKey: "currentUserData") //remove
            defaults.synchronize()
            if let user = user{
                if user.dictionary != nil {
                    let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                    defaults.set(data, forKey: "currentUserData")
                } else{
                    defaults.set(nil, forKey: "currentUserData")

                }
            } else {
                defaults.set(nil, forKey: "currentUserData")
            }
          //  user?.dictionary
           // defaults.set(user, forKey: "currentUser")
            defaults.synchronize()
        }
    }
}
