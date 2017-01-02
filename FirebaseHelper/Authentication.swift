//
//  Authentication.swift
//  FirebaseHelper
//
//  Created by Nguyen Nguyen on 12/23/16.
//  Copyright © 2016 Nguyen Nguyen. All rights reserved.
//

import FirebaseAuth

extension FirebaseHelper {
    open class Authentication: FIRAuth {
        // MARK: - Variables
        
       
        // MARK: - Constructors
        
        // MARK: - Public Properties
        public static var IsSignedIn: Bool {
            get {
                let a = FIRAuth.auth()?.currentUser
                print("A: \(a?.uid);email:\(a?.email);photoURL: \(a?.photoURL)")
                
                
                return FIRAuth.auth()?.currentUser != nil ? true:false
            }
        }

        // MARK: - Public Functions
        // Create User
        public static func CreateUser(withEmail: String, password: String) {
            FIRAuth.auth()?.createUser(withEmail: withEmail, password: password, completion: { (user: FIRUser?, error) in
                
                if error != nil {
                    print(error!)
                    return
                }
                
                print("User is registered")
            })
        }
        
        public static func CreateUser(withEmail email: String, password: String, completion:((_ userID: String?, _ error: Error?) -> Void)?) {
            
            FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user: FIRUser?, error) in
                
                if error != nil {
                    completion!("", error!)
                }
                
                completion!(user?.uid, nil)
            })
        }
        
        // Sign in
        public static func SignIn(withEmail: String, password: String) {
            FIRAuth.auth()?.signIn(withEmail: withEmail, password: password, completion: { (user: FIRUser?, error) in
                
                if error != nil {
                    print(error!)
                    return
                }
                
                print("Successfully logged in")
            })
        }
        
        public static func SignIn(withEmail email: String, password: String, completion:((_ user: FIRUser?, _ error: Error?) -> Void)?) {
            
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user: FIRUser?, error) in
                
                if error != nil {
                    completion!(nil, error)
                } else {
                    completion!(user, error)
                }
                
                
            })
        }

        
        // Sign out
        public static func SignOut() {
            let firebaseAuth = FIRAuth.auth()
            do {
                try firebaseAuth?.signOut()
                
                print("The user is signed out")
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
        }
        
        // Update user info
        public static func UpdateUserPhoto() {
            let changeRequest = FIRAuth.auth()?.currentUser?.profileChangeRequest()
            changeRequest?.displayName = "Nguyen Nguyen"
            changeRequest?.photoURL = NSURL(string: "http://abc.jpg") as URL?
            changeRequest?.commitChanges() { (error) in
                if error != nil {
                    print(error!)
                }
            }
        }
        
        // MARK: - Events and Actions
        // A variable that Hold actions and keys
        static var StateDidChangeActions : Dictionary<String, (() -> Void)>?
        
        // Initialize event
        static func initializeEventListener() {
             StateDidChangeActions = Dictionary<String, (() -> Void)>()
            
            // Add a listener
            FIRAuth.auth()?.addStateDidChangeListener() { (auth, user) in
                // Trigger all actions
                if (StateDidChangeActions?.count)! > 0 {
                    for i in StateDidChangeActions! {
                        i.value()
                    }
                }
            }
        }
        
        public static func addStateDidChangeAction(_ key: String, _ action: @escaping (() -> ())) {
            if StateDidChangeActions == nil {
                initializeEventListener()
            }

            // Create a new action
            // OR
            // Replace with a new action if the key exists
            StateDidChangeActions?[key] = action

            print("The action for key '\(key)' has been added")
        }
        
        public static func removeStateDidChangeAction(_ key: String) {
            // TODO: - Remove action by key
            if let index = StateDidChangeActions?.index(forKey: key) {
                
                StateDidChangeActions?.remove(at: index)
                
                print("The action for key '\(key)' has been removed")
            }
        }
        
        public static func removeAllStateDidChangeActions() {
            StateDidChangeActions?.removeAll()
        }
    }
}
