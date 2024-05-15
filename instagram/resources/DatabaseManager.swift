//
//  DatabaseManager.swift
//  instagram
//
//  Created by yousef Elaidy on 11/12/2023.
//
import FirebaseDatabase
import Foundation
public class DatabaseManager{
    static let shared = DatabaseManager()
    private let database = Database.database().reference()
    
    
    public func canCreateNewUser(with email: String, username:String,complition: (Bool)->Void ){
        complition(true)
    }
    
    public func insertusername(with email: String,username:String,complition:@escaping (Bool)->Void ){
        self.database.child(email.safedatabasekey()).setValue(["username": username]) { error, _ in
            if error == nil{
                complition(true)
                return
            }else{
                #imageLiteral(resourceName: "simulator_screenshot_1EE6B5F5-E32C-41EF-B342-8BD205164646.png")
                complition(false)
                return
            }
        }

    }
}
