//
//  NotificationMessage.swift
//  FirebaseHelper
//
//  Created by Nguyen Nguyen on 12/23/16.
//  Copyright © 2016 Nguyen Nguyen. All rights reserved.
//
import Foundation

extension FirebaseHelper.FirebaseNotification {
    public class Message {
        // MARK: - Variables
        open var Title = ""
        public var Subtitle = ""
        public var Body = ""
        public var Badge: NSNumber = 0
        
        // MARK: - Constructors
        init () {
            
        }
        
        init (_ object: Any?) {
            // Create a JSON instance
            let json:JSON = JSON(object ?? "")
            
            if let v = json["title"].string {
                Title = v
            }
            
            if let v = json["subtitle"].string {
                Subtitle = v
            }
            
            if let v = json["body"].string {
                Body = v
            }
            
            if let v = json["badge"].number {
                Badge = v
            }
        }
    }
}

