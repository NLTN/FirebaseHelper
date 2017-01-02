//
//  FirebaseHelper.swift
//  FirebaseHelper
//
//  Created by Nguyen Nguyen on 12/22/16.
//  Copyright © 2016 Nguyen Nguyen. All rights reserved.
//

import FirebaseAnalytics
import FirebaseInstanceID

open class FirebaseHelper: NSObject {
    // MARK: - Variables    

    // MARK: - Constructors
    public override init() {
        super.init()
    }
    
    // MARK: - Public Functions
    public static func registerForFirebase() {
        // Configure Firebase
        FIRApp.configure()
        //testManualConfigure()
        
        if let token = FIRInstanceID.instanceID().token() {
            print("My Token: \(token)")
        } else {
            print("Where is my token?")
        }
        
    }
    
    // MARK: - Private Optional Functions
    // Manual Configure. Just for testing and for fun.
    func testManualConfigure() {
        // TODO: Configure Firebase manually
        // [START configure_firebase]
        let _googleAppID = "1:127782854677:ios:43ed7f51a313c9bb"
        let _bundleID = "com.minhyen.FirebaseHelper"
        let _gcmSenderID = "127782854677"
        let _apiKey = "AIzaSyATYe8DtYbmCK-FKl-GOgXA3U_sspYpA3o"
        let _clientID = "127782854677-pg9c37riql2ca5jphvte7ob2tu8gelet.apps.googleusercontent.com"
        /**
         * The tracking ID for Google Analytics, e.g. @"UA-12345678-1", used to configure Google Analytics.
         */
        let _trackingID = ""
        let _androidClientID = ""
        let _databaseURL = "https://fblearning-c2980.firebaseio.com"
        let _storageBucket = "fblearning-c2980.appspot.com"
        
        /**
         * The URL scheme used to set up Durable Deep Link service.
         */
        let _deepLinkURLScheme = ""
        
        /**
         * Initializes a customized instance of FIROptions with keys. googleAppID, bundleID and GCMSenderID
         * are required. Other keys may required for configuring specific services.
         */
        let firOptions = FIROptions(googleAppID: _googleAppID, bundleID: _bundleID, gcmSenderID: _gcmSenderID, apiKey: _apiKey, clientID: _clientID, trackingID: _trackingID, androidClientID: _androidClientID, databaseURL: _databaseURL, storageBucket: _storageBucket, deepLinkURLScheme: _deepLinkURLScheme)
        
        
        // Manual configure
        FIRApp.configure(with: firOptions!)
        
        // [END configure_firebase]
    }

}

