//
//  DatabaseManager.swift
//  Messenger
//
//  Created by Ram Kaluri on 19/07/22.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    
    
    
    
    //validate new user using email
    
    public func userExists(with email : String , completion : @escaping((Bool) -> Void ))
    
    {
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        
        database.child(safeEmail).observeSingleEvent(of: .value, with: {snapshot in
            
            guard  snapshot.value as? String != nil else{
                
                completion(false)
                return
            }
            
            completion(true)
            
        })
        
        
    }
    
    
    
    
    
    //insert new user dtails in database
    public func insertUser(with user : chatAppuser , completion : @escaping (Bool)->Void){
        
        database.child(user.safeEmail).setValue([
            
            "firstname" : user.firstName,
            "lastname" : user.lastName
            
        ], withCompletionBlock: {error ,  _ in
            guard error == nil else{
                print("failed to add to database")
                completion(false)
                return
                
                
            }
            
            completion(true)
            
        })
        
        
    }
}



struct chatAppuser  {
    
    let firstName : String
    let lastName : String
    let emailAddress : String
    //let profilepicture : url
    
    var safeEmail : String {
        
        var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
        
    }
    var profilePictureFileName : String {
        
        return "\(safeEmail)_profilePicture.png"
        
    }
}

