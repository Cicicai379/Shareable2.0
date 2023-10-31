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
                print("database succeded")
                return
            }else{
                //failed
                completion (false)
                print("database failed")

                return
            }
        }
    }
    public func getUsername(forEmail email: String) -> String? {
        let databaseRef = Database.database().reference()
        var foundUsername: String?
        
        databaseRef.observeSingleEvent(of: .value) { (snapshot) in
            if let topLevelDict = snapshot.value as? [String: [String: String]] {
                print("Top-level dictionary: \(topLevelDict)")
                for (key, value) in topLevelDict {
                               if let username = value["username"] {
                                   print("Email: \(key), Username: \(username)")
                               }
                           }
                for (key, value) in topLevelDict {
                    print(key)
                    if email == key {
                        if let username = value["username"] {
                            foundUsername = username // Found the matching email, assign the username
                        }
                        print("!!"+(foundUsername ?? "not")!)
                        break // Exit the loop after finding the email
                    }
                }
            }
        }

        return foundUsername
    }

    // Usage:
   
}
