//
//  ChatCell.swift
//  ParseExample
//
//  Created by Bethany Bin on 2/22/18.
//  Copyright © 2018 Bethany Bin. All rights reserved.
//

import UIKit
import Parse

class ChatCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    var message: PFObject! {
        didSet {
            messageLabel.text = message.object(forKey: "text") as? String
            if let user = message.object(forKey: "user") as? PFUser{
                usernameLabel.text = user.username
            } else {
                usernameLabel.text = "🤖"
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
