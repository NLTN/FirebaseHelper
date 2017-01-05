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
        
        func mimeTypeForPath(path: String) -> String {
            let mimeTypes = [
                "html": "text/html",
                "htm": "text/html",
                "shtml": "text/html",
                "css": "text/css",
                "xml": "text/xml",
                "gif": "image/gif",
                "jpeg": "image/jpeg",
                "jpg": "image/jpeg",
                "js": "application/javascript",
                "atom": "application/atom+xml",
                "rss": "application/rss+xml",
                "mml": "text/mathml",
                "txt": "text/plain",
                "jad": "text/vnd.sun.j2me.app-descriptor",
                "wml": "text/vnd.wap.wml",
                "htc": "text/x-component",
                "png": "image/png",
                "tif": "image/tiff",
                "tiff": "image/tiff",
                "wbmp": "image/vnd.wap.wbmp",
                "ico": "image/x-icon",
                "jng": "image/x-jng",
                "bmp": "image/x-ms-bmp",
                "svg": "image/svg+xml",
                "svgz": "image/svg+xml",
                "webp": "image/webp",
                "woff": "application/font-woff",
                "jar": "application/java-archive",
                "war": "application/java-archive",
                "ear": "application/java-archive",
                "json": "application/json",
                "hqx": "application/mac-binhex40",
                "doc": "application/msword",
                "pdf": "application/pdf",
                "ps": "application/postscript",
                "eps": "application/postscript",
                "ai": "application/postscript",
                "rtf": "application/rtf",
                "m3u8": "application/vnd.apple.mpegurl",
                "xls": "application/vnd.ms-excel",
                "eot": "application/vnd.ms-fontobject",
                "ppt": "application/vnd.ms-powerpoint",
                "wmlc": "application/vnd.wap.wmlc",
                "kml": "application/vnd.google-earth.kml+xml",
                "kmz": "application/vnd.google-earth.kmz",
                "7z": "application/x-7z-compressed",
                "cco": "application/x-cocoa",
                "jardiff": "application/x-java-archive-diff",
                "jnlp": "application/x-java-jnlp-file",
                "run": "application/x-makeself",
                "pl": "application/x-perl",
                "pm": "application/x-perl",
                "prc": "application/x-pilot",
                "pdb": "application/x-pilot",
                "rar": "application/x-rar-compressed",
                "rpm": "application/x-redhat-package-manager",
                "sea": "application/x-sea",
                "swf": "application/x-shockwave-flash",
                "sit": "application/x-stuffit",
                "tcl": "application/x-tcl",
                "tk": "application/x-tcl",
                "der": "application/x-x509-ca-cert",
                "pem": "application/x-x509-ca-cert",
                "crt": "application/x-x509-ca-cert",
                "xpi": "application/x-xpinstall",
                "xhtml": "application/xhtml+xml",
                "xspf": "application/xspf+xml",
                "zip": "application/zip",
                "bin": "application/octet-stream",
                "exe": "application/octet-stream",
                "dll": "application/octet-stream",
                "deb": "application/octet-stream",
                "dmg": "application/octet-stream",
                "iso": "application/octet-stream",
                "img": "application/octet-stream",
                "msi": "application/octet-stream",
                "msp": "application/octet-stream",
                "msm": "application/octet-stream",
                "docx": "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
                "xlsx": "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
                "pptx": "application/vnd.openxmlformats-officedocument.presentationml.presentation",
                "mid": "audio/midi",
                "midi": "audio/midi",
                "kar": "audio/midi",
                "mp3": "audio/mpeg",
                "ogg": "audio/ogg",
                "m4a": "audio/x-m4a",
                "ra": "audio/x-realaudio",
                "3gpp": "video/3gpp",
                "3gp": "video/3gpp",
                "ts": "video/mp2t",
                "mp4": "video/mp4",
                "mpeg": "video/mpeg",
                "mpg": "video/mpeg",
                "mov": "video/quicktime",
                "webm": "video/webm",
                "flv": "video/x-flv",
                "m4v": "video/x-m4v",
                "mng": "video/x-mng",
                "asx": "video/x-ms-asf",
                "asf": "video/x-ms-asf",
                "wmv": "video/x-ms-wmv",
                "avi": "video/x-msvideo"
            ]
            let defaultMineType = "application/octet-stream"
            
            let url = NSURL(fileURLWithPath: path)
            let pathExtension = url.pathExtension
            
            
            if pathExtension != nil && mimeTypes.contains(where: { $0.0 == pathExtension!.lowercased() }) {
                return mimeTypes[pathExtension!.lowercased()]!
            }
            
            return defaultMineType
            
        }
        
        func GenerateFilename(fileExtension: String) -> String {
            return "/\(Int(Date.timeIntervalSinceReferenceDate * 1000)).\(fileExtension)"
        }
        
        public func UploadImage(image: UIImage, compression: CGFloat?, completion:((_ metadata: FIRStorageMetadata?, _ error: Error?) -> Void)?) {
            
            guard let imageData = UIImageJPEGRepresentation(image, compression ?? 1.0) else { return }
            
            let path = (Authentication.currentUser?.uid)! + GenerateFilename(fileExtension: "jpg")
            
            let metadata = FIRStorageMetadata()
            metadata.contentType = "image/png"
            
            
            DoUpload(data: imageData, storagePath: path, metadata: metadata, originalFileName: "a.jpg") { (metadata, error) in
                
                completion!(metadata, error)
            }
        }
        
        public func Upload(filePath: String, storagePath: String, completion:((_ metadata: FIRStorageMetadata?, _ error: Error?) -> Void)?) {
            let data = FileManager.default.contents(atPath: filePath)
            
            if data != nil {
                let url = NSURL(fileURLWithPath: filePath)
                let pathExtension = url.pathExtension

                
                
                
                let metadata = FIRStorageMetadata()
                metadata.contentType = mimeTypeForPath(path: filePath)
            }
        }
        
        public func DoUpload(data: Data, storagePath: String, metadata: FIRStorageMetadata?, originalFileName: String?, completion:((_ metadata: FIRStorageMetadata?, _ error: Error?) -> Void)?) {
            
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
