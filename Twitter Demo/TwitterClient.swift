//
//  TwitterClient.swift
//  Twitter Demo
//
//  Created by David Yuan on 2/24/17.
//  Copyright © 2017 David Yuan. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    static let sharedInstance = TwitterClient(baseURL: URL(string: "https://api.twitter.com")!, consumerKey: "vdqohgK10iC8k7HDtVXgu1bKk", consumerSecret: "Pk6Ifm0hzXaYCd2WSKGRI5bCT76WImtpbIop4195HQ5NXvILwt")
    var loginSuccess: (() -> ())?
    var loginFailure: ((Error) -> ())?
    func currentAccount(success: @escaping (Users) -> (), failure: @escaping (Error) -> ()) {
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            // print("account: \(response)")
            let userDictionary = response as? NSDictionary
            
            let user = Users(dictionary: userDictionary!)
            success(user)
            
            print(user.profileURL!)
        }, failure: { (task:URLSessionDataTask?, error: Error) in
            failure(error)
        })

    }
    func homeTimeline(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()){
        
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            //print("account: \(response)")
            let dictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
            success(tweets)
        }, failure: { (task:URLSessionDataTask?, error: Error) in
            print(error.localizedDescription)
            failure(error)
        })
    }
    func login(success: @escaping () -> (), failure: @escaping (Error) -> ()){
        loginSuccess = success
        loginFailure = failure
        
        TwitterClient.sharedInstance!.deauthorize()
        TwitterClient.sharedInstance!.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string: "mytwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential?) -> Void in
            let twiturl = "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken!.token!)"
            let theurl = URL(string: twiturl)
            UIApplication.shared.open(theurl!)
            
        }, failure: { (error:Error?) -> Void in
            self.loginFailure?(error!)
        })

    }
    func handleOpenUrl(url: URL){
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential?) -> Void in //print("got it")
            
            self.currentAccount(success: { (user: Users) in
                Users.currentUser = user
                self.loginSuccess?()
            }, failure: { (error: Error) in
                self.loginFailure?(error)
            })
            
            
        }) { (error: Error?) -> Void in
            self.loginFailure?(error!)
        }
        
      

    }
}
