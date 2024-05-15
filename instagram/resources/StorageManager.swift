//
//  Storage.swift
//  instagram
//
//  Created by yousef Elaidy on 11/12/2023.
//

import Foundation
import FirebaseStorage
import FirebaseFirestore


public class StorageManager{
    static let shared = StorageManager()
    private let bucket = Storage.storage().reference()
    
    public enum igstorageerror: Error{
        case failedtodownload
    }
    
    public func registerNewUser(username : String, email : String, password : String){
        
    }
    public func loginUser(username : String?, email : String?, password : String?){
        
        
    }
    
    public func uploaduserphotopost(model: UserPost, completion: (Result<URL,Error>) -> Void){
        
    }
    public func downloadimage(with reference: String ,completion:@escaping (Result<URL,igstorageerror>) -> Void){
        bucket.child(reference).downloadURL (completion: { url, error in
            guard let url=url , error == nil else{
                completion(.failure(.failedtodownload))
                return
            }
            completion(.success(url))
        })
    }
}


    
    
public enum userposttype: String{
        case photo = "photo"
        case video = "video"
    }
    // represent a userpost
   
