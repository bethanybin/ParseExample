//
//  ChatViewController.swift
//  ParseExample
//
//  Created by Bethany Bin on 2/22/18.
//  Copyright © 2018 Bethany Bin. All rights reserved.
//

import UIKit
import Parse
class ChatViewController: UIViewController, UITableViewDataSource{

  
    var messages: [PFObject] = []
    let chatMessage = PFObject(className: "Message")
    @IBOutlet weak var textMessageField: UITextField!
    @IBAction func sendButton(_ sender: Any) {
        chatMessage["text"] = textMessageField.text ?? ""
        chatMessage["user"] = PFUser.current()
        chatMessage.saveInBackground { (success, error) in
            if success {
                print("The message was saved!")
                self.textMessageField.text = ""
            } else if let error = error {
                print("Problem saving message: \(error.localizedDescription)")
            }
        }
    }
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.refresh), userInfo: nil, repeats: true)

    }

    /*@IBAction func logoutButton(_ sender: Any) {
        PFUser.logOutInBackgroundWithBlock { (error: NSError?) in
            // PFUser.current() will now be nil
            } as! PFUserLogoutResultBlock as! PFUserLogoutResultBlock
    }*/
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        if let user = chatMessage["user"] as? PFUser {
            // User found! update username label with username
            cell.usernameLabel.text = user.username
        } else {
            // No user found, set default username
            cell.usernameLabel.text = "🤖"
        }
        return cell
    }
    
    
    @objc func refresh(){
        let query = PFQuery(className: "Messages")
        query.includeKey("user")
        query.addDescendingOrder("createdAt")
        query.findObjectsInBackground { (messages: [PFObject]?, error: Error?) in
            if error == nil{
                if let messages = messages{
                    self.messages = messages
                    print(messages.count)
                    self.tableView.reloadData()
                }
            }
            self.tableView.reloadData()
        }
        
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
