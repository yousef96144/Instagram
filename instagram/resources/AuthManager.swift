//
//  AuthManager.swift
//  instagram
//
//  Created by yousef Elaidy on 11/12/2023.
//

import Foundation
import FirebaseAuth
public class AuthManager{
    static let shared = AuthManager()
    
    public func registerNewUser(username : String, email : String, password : String, complition:@escaping (Bool)->Void){
        DatabaseManager.shared.canCreateNewUser(with: email, username: username) { cancreate in
            if cancreate{
                Auth.auth().createUser(withEmail: email, password: password) { Result, error in
                    guard error == nil , Result != nil else{
                        complition(false)
                        return
                    }
                    DatabaseManager.shared.insertusername(with: email, username: username) { success in
                        if success{
                            complition(true)
                            return
                        }else{
                            complition(false)
                            return
                        }
                            
                    }
                }
            }else{
                complition(false)
            }
        }
    }
    public func loginUser(username : String?, email : String?, password : String? , complition:@escaping ((Bool)->Void)){
        if let email = email{
            Auth.auth().signIn(withEmail: email, password: password!) { authintecationerror, error in
                guard authintecationerror != nil , error == nil else{
                    complition(false)
                    return
                }
                complition(true)
                
            }
        }
        
    }
    
    public func logOut(complition: (Bool)-> Void){
        do{
            try Auth.auth().signOut()
            complition(true)
            return
        }catch{
            print(error)
            complition(false)
            return
        }
    }
}
