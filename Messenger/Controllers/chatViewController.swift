//
//  chatViewController.swift
//  Messenger
//
//  Created by Ram Kaluri on 21/07/22.
//

import UIKit
import MessageKit




struct message : MessageType {
        var sender: SenderType
        var messageId: String
        var sentDate: Date
        var kind: MessageKind

}

struct sender : SenderType {
    var senderId: String
    var displayName: String
    var photoURL : String

}




class chatViewController: MessagesViewController {
    
    private var messages = [message]()
    
    private let selfsender = sender(senderId:  "1" , displayName: "joe smith", photoURL: "")

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
       
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        
        //messagesappend
   
        messages.append(message(sender: selfsender, messageId: "1", sentDate: Date(), kind: .text("hi")))
        messages.append(message(sender: selfsender, messageId: "1", sentDate: Date(), kind: .text("hi. this is joe smith . good morning")))
        messages.append(message(sender: selfsender, messageId: "1", sentDate: Date(), kind: .text("hi. this is joe smith . good morning.hi. this is joe smith . good morning")))
        
    }
    

   

}

extension chatViewController : MessagesDataSource , MessagesLayoutDelegate  , MessagesDisplayDelegate {
    func currentSender() -> SenderType {
        return selfsender
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return  messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
    
    
    
    
    
    
    
    
}
