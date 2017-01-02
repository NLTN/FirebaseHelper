//
//  Notification.swift
//  FirebaseHelper
//
//  Created by Nguyen Nguyen on 12/22/16.
//  Copyright © 2016 Nguyen Nguyen. All rights reserved.
//

// IMPORTANT
// Add the -ObjC linker flag: -ObjC

import FirebaseAnalytics
import FirebaseMessaging
import FirebaseInstanceID
import UserNotifications

extension FirebaseHelper {
    open class FirebaseNotification: NSObject, UIApplicationDelegate, FIRMessagingDelegate {
        
        // MARK: - Event Handler
        open var DidReceiveNotification: ((_ message: Message) -> Void)?

        // MARK: - Variables
        let gcmMessageIDKey = "gcm.message_id"
        
        // MARK: - Properties
        var TokenID: String? {
            get {
                if let token = FIRInstanceID.instanceID().token() {
                    return token
                } else {
                    return nil
                }
            }
        }

        // MARK: - Constructors
        public override init() {
            super.init()
            FIRMessaging.messaging().remoteMessageDelegate = self
        }
        
        public init(_ application: UIApplication) {
            super.init()
            FIRMessaging.messaging().remoteMessageDelegate = self
        }
        
        // MARK: - Public Functions

        // MARK: - Private Functions

        // Test
        func testReceive(withNotification notification: FirebaseNotification) {
            // TODO: [Just for testing]. Print out all notification.
            print("I received a notificaiton at \(Date())")
            print("Content: \(notification)")
        }
        
        // [START refresh_token]
        func tokenRefreshNotification(_ notification: FirebaseNotification) {
            // TODO: Get or create a token, and then call the function connectToFcm()
            
            if let refreshedToken = FIRInstanceID.instanceID().token() {
                print("InstanceID token: \(refreshedToken)")
            }
            
            // Connect to FCM since connection may have failed when attempted before having a token.
            connectToFcm()
        }
        // [END refresh_token]
        
        // [START connect_to_fcm]
        func connectToFcm() {
            // TODO: Connect to Firebase Clould Messaging
            // Won't connect since there is no token
            guard FIRInstanceID.instanceID().token() != nil else {
                return;
            }
            
            // Disconnect previous FCM connection if it exists.
            FIRMessaging.messaging().disconnect()
            
            FIRMessaging.messaging().connect { (error) in
                if error != nil {
                    print("Unable to connect with FCM. \(error)")
                } else {
                    print("Connected to FCM.")
                }
            }
        }
        // [END connect_to_fcm]
        
        // MARK: - Event Handlers
        // [START connect_on_active]
        public func applicationDidBecomeActive(_ application: UIApplication) {
            print(">>applicationDidBecomeActive")
            connectToFcm()
        }
        // [END connect_on_active]
        
        // [START disconnect_from_fcm]
        public func applicationDidEnterBackground(_ application: UIApplication) {
            print(">>applicationDidEnterBackground")
            
            // FIRMessaging.messaging().disconnect()
            // print("Disconnected from FCM.")
        }
        // [END disconnect_from_fcm]
        
        
        // [START receive_message - Available for IOS 8.* - 9.*]
        public func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
            // If you are receiving a notification message while your app is in the background,
            // this callback will not be fired till the user taps on the notification launching the application.
            // TODO: Handle data of notification
            // Print message ID.
            if let messageID = userInfo[gcmMessageIDKey] {
                print("Message ID: \(messageID)")
            }
            
            // test
            
            let msg = Message(userInfo["notification"])
            
            DidReceiveNotification?(msg)
        }
        
        public func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
            // If you are receiving a notification message while your app is in the background,
            // this callback will not be fired till the user taps on the notification launching the application.
            // TODO: Handle data of notification
            // Print message ID.
            if let messageID = userInfo[gcmMessageIDKey] {
                print("Message ID: \(messageID)")
            }

            completionHandler(UIBackgroundFetchResult.newData)
            
            let msg = Message(userInfo["notification"])

            DidReceiveNotification?(msg)
        }
        // [END receive_message - Available for IOS 8.* - 9.*]
        
        
        // Receive data message on iOS 10 devices while app is in the foreground.
        public func applicationReceivedRemoteMessage(_ remoteMessage: FIRMessagingRemoteMessage) {
            if remoteMessage.appData["notification"] != nil {
                let msg = Message(remoteMessage.appData["notification"])
                DidReceiveNotification?(msg)
            }
        }
    }
}
