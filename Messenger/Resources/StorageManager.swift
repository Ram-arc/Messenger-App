//
//  StorageManager.swift
//  Messenger
//
//  Created by Ram Kaluri on 26/07/22.
//

import Foundation
import FirebaseStorage


final class StorageManager {
    
    static let shared = StorageManager()
    
    private let storage = Storage.storage().reference()
    
    public typealias uploadPictureCompletion = (Result<String , Error>) ->Void
    
    public func uploadprofileImage(with data : Data ,filename : String ,completion : @escaping uploadPictureCompletion){
        
        storage.child("images/\(filename)").putData(data, metadata: nil, completion: { metadata , error in
            
            guard error == nil else {
                print("failed to upload")
                completion(.failure( storageErrors.failedtoupload))
                return
            }
         self.storage.child("images/\(filename)").downloadURL(completion: { url ,error in
                
                guard let url = url else{
                    print(" failed to get download url ")
                    completion(.failure(storageErrors.failedtoGetDowloadUrl))
                    return
                    
                }
                
            let urlString = url.absoluteString
            print("dowload url : \(urlString)")
            completion(.success(urlString))
            
            
            })
           
        })
        
      
        
        
    }
    
    
    public enum storageErrors : Error {
         
         case failedtoupload
        case failedtoGetDowloadUrl
         
         
     }
    
    
}
