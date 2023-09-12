//
//  StorageManager.swift
//  share
//
//  Created by cici on 7/6/2023.
//

import Foundation
import FirebaseStorage


public class StorageManager
{
    
    static let shared = StorageManager()
    private let bucket = Storage.storage().reference()
    
    public enum StorageMangerError: Error{
        case failedToDownload
    }
    
    //MARK: - Public
    public func uploadUserPost(model: UserPost, email: String, completion: @escaping(Result<URL, Error>) -> Void){
        
        
    }
    

    public func downloadImage(with reference: String, completion: @escaping (Result<URL, StorageMangerError>) -> Void) {
        bucket.child(reference).downloadURL(completion: {url, error in
            guard let url = url, error == nil else{
                completion(.failure(.failedToDownload))
                return
            }
            completion(.success(url))
        })
    }
    
}
