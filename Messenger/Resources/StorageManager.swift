//
//  StorageManager.swift
//  Messenger
//
//  Created by Laerdon Kim on 7/19/20.
//  Copyright © 2020 Laerdon Kim. All rights reserved.
//

import Foundation
import FirebaseStorage

/// Allows you to get, fetch, and upload files to Firebase Storage
final class StorageManager {
    
    static let shared = StorageManager()
    
    private init() {}
    
    private let storage = Storage.storage().reference()
    
    public typealias UploadPictureCompletion = (Result<String, Error>) -> Void
    
    /// Uploads picture to Firebase storage and returns completion with URL string to download
    public func uploadProfilePicture(with data: Data, fileName: String, completion: @escaping UploadPictureCompletion) {
        storage.child("images/\(fileName)").putData(data, metadata: nil, completion: {[weak self] metadata, error in
            guard let strongSelf = self else {
                return
            }
            
            guard error == nil else {
                print("Failed to upload data to Firebase for picture")
                completion(.failure(StorageErrors.failedToUpload))
                return
            }
            
            strongSelf.storage.child("images/\(fileName)").downloadURL(completion: {url, error in
                guard let url = url else {
                    print("Failed to get download URL")
                    completion(.failure(StorageErrors.failedToGetDownloadUrl))
                    return
                }
                
                let urlString = url.absoluteString
                print("Download URL returned: \(urlString)")
                completion(.success(urlString))
            })
        })
    }
    
    /// Uploads image that will be sent in a conversation message
    public func uploadMessagePhoto(with data: Data, fileName: String, completion: @escaping UploadPictureCompletion) {
        storage.child("message_images/\(fileName)").putData(data, metadata: nil, completion: {[weak self] metadata, error in
            guard error == nil else {
                print("Failed to upload data to Firebase for picture")
                completion(.failure(StorageErrors.failedToUpload))
                return
            }
            
            self?.storage.child("message_images/\(fileName)").downloadURL(completion: {url, error in
                guard let url = url else {
                    print("Failed to get download URL")
                    completion(.failure(StorageErrors.failedToGetDownloadUrl))
                    return
                }
                
                let urlString = url.absoluteString
                print("Download URL returned: \(urlString)")
                completion(.success(urlString))
            })
        })
    }
    
    /// Uploads video that will be sent in a conversation message
    public func uploadMessageVideo(with fileUrl: URL, fileName: String, completion: @escaping UploadPictureCompletion) {
        storage.child("message_videos/\(fileName)").putFile(from: fileUrl, metadata: nil, completion: {[weak self] metadata, error in
            guard error == nil else {
                print("Failed to upload video file to Firebase for picture")
                completion(.failure(StorageErrors.failedToUpload))
                return
            }
            
            self?.storage.child("message_videos/\(fileName)").downloadURL(completion: {url, error in
                guard let url = url else {
                    print("Failed to get download URL")
                    completion(.failure(StorageErrors.failedToGetDownloadUrl))
                    return
                }
                
                let urlString = url.absoluteString
                print("Download URL returned: \(urlString)")
                completion(.success(urlString))
            })
        })
    }
    
    public enum StorageErrors: Error {
        case failedToUpload
        case failedToGetDownloadUrl
    }
    
    public func downloadURL(for path: String, completion: @escaping (Result<URL, Error>) -> Void) {
        let reference = storage.child(path)
        
        reference.downloadURL(completion: {url, error in
            guard let url = url, error == nil else {
                completion(.failure(StorageErrors.failedToGetDownloadUrl))
                return
            }
            
            completion(.success(url))
        })
    }
}
