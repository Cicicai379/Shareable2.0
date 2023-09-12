//
//  DatabaseManager.swift
//  share
//
//  Created by cici on 7/6/2023.
//

import Foundation
import FirebaseDatabase

public class DatabaseManager
{
    
    static let shared = DatabaseManager()
    private let database = Database.database().reference()
    //MARK: - Public
    
    public func canCreateNewUser(with email:String, username: String, completion: (Bool) -> Void){
        completion(true)
    }
    public func insertNewUser(with email: String, username: String, completion: @escaping (Bool) -> Void){
        let emailKey = email.safeDatabaseKey()
        print(emailKey)
        database.child(emailKey).setValue(["username":username]){ error, _ in
            if error == nil{
                //succeed
                completion ( true)
                return
            }else{
                //failed
                completion (false)
                return
            }
        }
    }
}
