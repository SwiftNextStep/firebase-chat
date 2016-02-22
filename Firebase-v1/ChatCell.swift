//
//  ChatCell.swift
//  Firebase-v1

//

import UIKit

class ChatCell: UITableViewCell {
    
    @IBOutlet weak var chatPix: UIImageView!
    @IBOutlet weak var chatText: UILabel!
    
    var cellPost: Post? {
        didSet {
            updateCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func updateCell() {
        var theSender = "unknown"
        if let aSender = users[cellPost!.sender!] {
            theSender = aSender
        }
        
        switch theSender {
        case "Tyche the Dog" : chatPix.image = UIImage(named: theSender)
        case "SwaxMaster"    : chatPix.image = UIImage(named: theSender)
        case "Ziggster"      : chatPix.image = UIImage(named: theSender)
            
        default: chatPix.image = UIImage(named: "blank")
        }
        
        chatPix.layer.cornerRadius = chatPix.frame.size.width / 2
        chatPix.clipsToBounds = true
        
        if let message = cellPost?.message {
            chatText.text = "\(theSender) : \(message)"
        }
    }
}
