//
//  Storage.swift
//  FirebaseHelper
//
//  Created by Nguyen Nguyen on 1/4/17.
//  Copyright © 2017 Nguyen Nguyen. All rights reserved.
//

import Foundation
import FirebaseStorage

extension FirebaseHelper {
    open class Storage: NSObject {
        // MARK: - Variables
        var storageRef: FIRStorageReference!
        
        public override init() {
            
            storageRef = FIRStorage.storage().reference()

        }
        
        public func TestUpload() {
            let image = UIImage(named: "first")
            UploadImage(image: image!, compression: 1) { (metadata, error) in
                if error != nil {
                    print(error!)
                } else {
                    print(metadata?.downloadURL() ?? "Unknown download url")
                }
            }
//            guard let imageData = UIImageJPEGRepresentation(image!, 0.8) else { return }
//            
//            let imagePath = (Authentication.currentUser?.uid)! +
//            "/\(Int(Date.timeIntervalSinceReferenceDate * 1000)).jpg"
//            let metadata = FIRStorageMetadata()
//            metadata.contentType = "image/jpeg"
//            
//            self.storageRef.child(imagePath).put(imageData, metadata: metadata) { (metadata, error) in
//                    if let error = error {
//                        print("Error uploading: \(error)")
//                        //self.urlTextView.text = "Upload Failed"
//                        return
//                    }
//                print("upload success")
//                    //self.uploadSuccess(metadata!, storagePath: imagePath)
//            }
        }
        
        public func UploadImage(image: UIImage, compression: CGFloat?, completion:((_ metadata: FIRStorageMetadata?, _ error: Error?) -> Void)?) {
            
            guard let imageData = UIImageJPEGRepresentation(image, compression ?? 1.0) else { return }
            
            let path = (Authentication.currentUser?.uid)! +
            "/\(Int(Date.timeIntervalSinceReferenceDate * 1000)).png"
            
            let metadata = FIRStorageMetadata()
            metadata.contentType = "image/png"
            
            
            Upload(data: imageData, storagePath: path, metadata: metadata, originalFileName: "a.jpg") { (metadata, error) in
                
                completion!(metadata, error)
            }
        }
        
        public func Upload(data: Data, storagePath: String, metadata: FIRStorageMetadata?, originalFileName: String?, completion:((_ metadata: FIRStorageMetadata?, _ error: Error?) -> Void)?) {
            
            self.storageRef.child(storagePath).put(data, metadata: metadata) { (metadata, error) in
                if let error = error {
                    print("Error uploading: \(error)")
                    return
                }
                print("upload success")
                completion!(metadata, error)
            }
        }
    }
}
