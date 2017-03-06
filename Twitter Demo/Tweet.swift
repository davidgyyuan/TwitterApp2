//
//  Tweet.swift
//  Twitter Demo
//
//  Created by David Yuan on 2/24/17.
//  Copyright © 2017 David Yuan. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var text: String?
    var timestamp: Date?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    var user: Users?
    var favorited: Bool?
    var retweeted: Bool?
    var fimage: UIImage?
    var rimage: UIImage?
    var id: CLongLong?
    var numf: Int = 0
    var numr: Int = 0
    init(dictionary: NSDictionary){
        user = Users(dictionary: (dictionary["user"] as? NSDictionary)!) as? Users
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favourites_count"] as? Int) ?? 0
        let timestampString = dictionary["created_at"] as? String
        if let timestampString = timestampString {
            let formatter = DateFormatter()
            formatter.dateFormat="EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.date(from: timestampString)
        }
        favorited = dictionary["favorited"] as? Bool
        retweeted = dictionary["retweeted"] as? Bool
        id=dictionary["id"] as? CLongLong
        numf = (dictionary["favorite_count"] as? Int)!
        numr = (dictionary["retweet_count"] as? Int)!
        if(favorited)!{
            fimage = #imageLiteral(resourceName: "favoriteson")
        }else{
            fimage = #imageLiteral(resourceName: "favorites")
        }
        if(retweeted)!{
            rimage = #imageLiteral(resourceName: "repeaton")
        }
        else{
            rimage = #imageLiteral(resourceName: "repeat")
        }
        
    }
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in dictionaries{
            let tweet = Tweet(dictionary: dictionary)
            
            tweets.append(tweet)
        }
        return tweets
    }
}
