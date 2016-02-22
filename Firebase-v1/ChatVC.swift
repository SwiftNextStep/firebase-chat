//
//  ChatVC
//  Firebase-v1
//

import UIKit
import Firebase

class ChatVC: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var chatHandleLabel: UILabel!
    @IBOutlet weak var chatText: UITextView!
    @IBOutlet weak var chatTable: UITableView!
    
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatTable.dataSource = self
        
        // Add ability to tab chat label as "send" button
        let labelTappedRecognizer = UITapGestureRecognizer(target: self, action: "tapLabel:")
        labelTappedRecognizer.numberOfTapsRequired = 1
        chatHandleLabel.addGestureRecognizer(labelTappedRecognizer)
        
        chatHandleLabel.text = HANDLE
        
        setupFBUserObservers()
        setupFBPostObservers()
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("chatCell", forIndexPath: indexPath) as! ChatCell
        cell.cellPost = posts[indexPath.row]
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    @IBAction func logOffChat(sender: UIButton) {
        FirebaseUsers.childByAppendingPath(KEY_UID).updateChildValues([KEY_ISONLINE:false])
        
        // Clear globals for new login attemp
        KEY_UID = ""
        HANDLE = ""
        NEW_USER = false
        
        FirebaseApp.unauth()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func tapLabel(sender: UILabel) {
        if chatText.text != "" {
            let details = ["message":chatText.text,"sender":KEY_UID]
            FirebasePosts.childByAutoId().setValue(details)
            chatText.text = ""
        }
        
        // Close keyboard
        chatText.resignFirstResponder()
    }
    
    func setupFBPostObservers() {
        
        FirebasePosts.observeEventType(.ChildAdded) { (snapshot: FDataSnapshot!) -> Void in
            let theMessage = snapshot.value["message"] as! String
            let theSender = snapshot.value["sender"] as! String
            
            let newPost = Post(id: snapshot.key, message: theMessage, sender: theSender)
            self.posts.append(newPost)
            self.chatTable.reloadData()
            
        }
    }
    
    func setupFBUserObservers() {
        FirebaseUsers.observeEventType(.ChildAdded, withBlock: { snapshot in
            
            // Create a dictionary holding our unique users
            users.updateValue(snapshot.value["name"] as! String, forKey: snapshot.key)
            
            // Capture current user and set their chat handle
            if snapshot.key == KEY_UID {
                if let myhandle = snapshot.value["name"] as? String {
                    HANDLE = myhandle
                    self.chatHandleLabel.text = HANDLE
                }
            }
        })
        
        FirebaseUsers.observeEventType(.ChildChanged, withBlock: { snapshot in
            
            if snapshot.key == KEY_UID {
                if let myhandle = snapshot.value["name"] as? String {
                    HANDLE = myhandle
                    self.chatHandleLabel.text = HANDLE
                }
            }
        })
    }
    
    deinit
    {
        // must also remove observers for any child observers added
        FirebaseUsers.removeAllObservers()
        FirebasePosts.removeAllObservers()
    }
}

