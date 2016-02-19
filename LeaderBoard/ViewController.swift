//
//  ViewController.swift
//  LeaderBoard
//
//  Created by AppCenter on 2/18/16.
//  Copyright © 2016 AppCenter. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController,FBSDKLoginButtonDelegate {

    @IBOutlet weak var loginButton: FBSDKLoginButton!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var name: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "blr.jpg")?.drawInRect(self.view.bounds)
        
        let image: UIImage! = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        self.view.backgroundColor = UIColor(patternImage: image)
        
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "img1.jpeg")!).
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func login(sender: AnyObject) {

        print("In login")
        loginButton.readPermissions = ["public_profile", "email", "user_friends"];
        loginButton.delegate = self
    
    }
    
    
    
    
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!)
    {
    print("In loginButton")
        
        FBSDKGraphRequest.init(graphPath: "me", parameters: ["fields":"first_name, last_name, picture.type(large)"]).startWithCompletionHandler { (connection, result, error) -> Void in
            
            if(error == nil && result != nil){
                print("Permission successfully revoked. This app will no longer post to Facebook on your behalf.")
                print("result = \(result)")
            } else {
                if let error: NSError = error {
                    if let errorString = error.userInfo["error"] as? String {
                        print("errorString variable equals: \(errorString)")
                    }
                } else {
                    print("No value for error key")
                }
            }
            
            
            let strFirstName: String = (result.objectForKey("first_name") as? String)!
            let strLastName: String = (result.objectForKey("last_name") as? String)!
            let strPictureURL: String = (result.objectForKey("picture")?.objectForKey("data")?.objectForKey("url") as? String)!
            self.name.text = "Welcome, \(strFirstName) \(strLastName)"
            self.icon.image = UIImage(data: NSData(contentsOfURL: NSURL(string: strPictureURL)!)!)
            }
        
    }

    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!)
    {

    PFUser.logOut()
        
    let loginManager: FBSDKLoginManager = FBSDKLoginManager()
       loginManager.logOut()
        
                icon.image = UIImage(named:"tzuk1.png")!
       name.text = "I am Back !!!!!"
     

    }
    
   }

