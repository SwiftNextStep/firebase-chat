//
//  LoginVC.swift
//  Firebase-v1
//

import UIKit
import Firebase

//
// Contains important code in AppDelegate.swift
//

class LoginVC: UIViewController {
    
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    
    private struct storyboard {
        static let chatSegue = "goToChat"
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if FirebaseApp.authData != nil {
            KEY_UID = FirebaseApp.authData.uid
            FirebaseApp.childByAppendingPath("users").childByAppendingPath(KEY_UID).updateChildValues(["isOnline":true])
            performSegueWithIdentifier(storyboard.chatSegue, sender: nil)
        } else {
            // We likely returned from chatVC as a logoff
        }
        
    }
    
    @IBAction func userLogin(sender: UIButton) {
        FirebaseApp.authUser(userEmail.text, password: userPassword.text) { (error: NSError!, authData: FAuthData!) -> Void in
            if error != nil {
                var errorString = ""
                
                switch error.code {
                case CODE_BLANK_PASSWORD: errorString = "Invalid Password"
                case CODE_INVALID_EMAIL: errorString = "Invalid Email address"
                    
                default: errorString = error.localizedDescription
                }
                if error.code != CODE_ACCOUNT_NONEXIST {
                    let alert = UIAlertController(title: "Firebase Chat", message: errorString, preferredStyle: .Alert)
                    let okAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
                    alert.addAction(okAction)
                    self.presentViewController(alert, animated: false, completion: nil)
                }
                if error.code == CODE_ACCOUNT_NONEXIST {
                    FirebaseApp.createUser(self.userEmail.text, password: self.userPassword.text, withCompletionBlock: { (error: NSError!) -> Void in
                        if error != nil {
                            print(error.localizedDescription)
                        } else {
                            NEW_USER = true
                            self.getUserName()
                        }
                    })
                }
                
            } else {
                self.logIn()
            }
            
        }
    }
    
    func logIn() {
        FirebaseApp.authUser(self.userEmail.text, password: self.userPassword.text) { (error: NSError!, authData: FAuthData!) -> Void in
            KEY_UID = authData.uid
            if error != nil {
                print(error.localizedDescription)
            } else {
                if NEW_USER {
                    FirebaseApp.childByAppendingPath("users").childByAppendingPath(KEY_UID).setValue(["isOnline":true,"name":HANDLE])
                } else {
                    FirebaseApp.childByAppendingPath("users").childByAppendingPath(KEY_UID).updateChildValues(["isOnline":true])
                }
            }
        }
        performSegueWithIdentifier(storyboard.chatSegue, sender: nil)
    }
    
    func getUserName() {
        var newChatTextField: UITextField?
        
        let chatName = UIAlertController(title: "Firebase Chat", message: "Enter your chat handle:", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "Done", style: .Default) { (UIAlertAction) -> Void in
            if let chatHandle = newChatTextField?.text {
                HANDLE = chatHandle
                self.logIn()
            }
        }
        
        chatName.addAction(okAction)
        chatName.addTextFieldWithConfigurationHandler { (username: UITextField) -> Void in
            newChatTextField = username
        }
        self.presentViewController(chatName, animated: false, completion: nil)
        
    }
}
