//
//  StorageManager.swift
//  share
//
//  Created by cici on 7/6/2023.
//

import Foundation
import FirebaseAuth


public class AuthManager
{
    
    static let shared = AuthManager()
    
    //MARK: - Public
    public func registerNewUser(username: String, email: String, password: String, completion: @escaping (Bool)->Void){
        /* check: username is available
                    email is available
                    create account
                    insert to database
         */
        DatabaseManager.shared.canCreateNewUser(with: email, username: username){ canCreate in
            if canCreate{
                Auth.auth().createUser(withEmail: email, password: password){result,error in
                    guard  result == nil, error == nil else{
                        //firebase error
                        completion(false)
                        return
                    }
                    // insert to database
                    DatabaseManager.shared.insertNewUser(with:email, username:username){inserted in
                        if inserted{
                            completion(true)
                            return
                        }
                        completion(false)
                        return
                    }
                }
            } else{
                //username or email not valid
                completion(false)
                return
            }
        }
    }
    public func loginNewUser(username: String?, email: String?, password: String, completion: @escaping (Bool) -> Void){
        
        if let email = email {
            Auth.auth().signIn(withEmail: email, password: password){ (authResult, error) in
                guard authResult != nil, error == nil else{
                    completion(false)
                    return
                }
                completion(true)
                return
            }
        }
        else if let username = username {
            print(username)
        }
        
    }
    
    public func logOut(completion: (Bool)->Void){
        do{
            try Auth.auth().signOut()
            completion(true)
            return
        }
        catch{
            print(error)
            completion(false)
            return
        }
    }
    
    //MARK: PRIVATE
    
   
}

