//
//  Database.swift
//  FirebaseHelper
//
//  Created by Nguyen Nguyen on 12/23/16.
//  Copyright © 2016 Nguyen Nguyen. All rights reserved.
//

import FirebaseDatabase

extension FirebaseHelper {
    public enum Condition {
        case contain(String), equalToString(String), equalTo(NSNumber),
        greaterThanOrEqualTo(NSNumber), lessThanOrEqualTo(NSNumber),
        greaterThan(NSNumber), lessThan(NSNumber),
        between(NSNumber, NSNumber)
    }
    
    public enum ObservingMode: Int {
        case readDataOnce, listenForChanges
    }
    
    open class Database: NSObject {
        // MARK: - Variables

        // Database reference
        var ref: FIRDatabaseReference!
        
        // MARK: - Constructors
        public override init() {
            super.init()
            
            // Create a database reference
            ref = FIRDatabase.database().reference()
        }
        
        public func getReference() -> FIRDatabaseReference {
            return ref
        }
   
        func getQuery() -> FIRDatabaseQuery {
            return (ref?.child("UserConfigurations").child("Theme"))!
        }
        
        public func SaveValue() {
            let dbRef = ref?.child((FirebaseHelper.Authentication.currentUser?.uid)! + "/myFiles/myFile")
            dbRef?.setValue("abcdef")
            
        }
        
        public func Query(path: String, orderBy: String, condition: Condition, observingMode: ObservingMode, eventType: FIRDataEventType, completion:((_ snapshot: NSDictionary?) -> Void)?) {
            
            switch condition {
            case .equalToString(let value):
                doQuery(path: path, orderBy: orderBy, startingValue: value, endingValue: value + "\u{f8ff}", observingMode: observingMode, eventType: eventType, completion: { (dict) in
                    
                    completion!(dict)
                    
                })
                break
            case .equalTo(let value):
                doQuery(path: path, orderBy: orderBy, startingValue: value, endingValue: value, observingMode: observingMode, eventType: eventType, completion: { (dict) in
                    
                    completion!(dict)
                    
                })
                break
            case .greaterThan(let value):
                doQuery(path: path, orderBy: orderBy, startingValue: value.doubleValue.adding(1/100000000), endingValue: nil, observingMode: observingMode, eventType: eventType, completion: { (dict) in
                    
                    completion!(dict)
                    
                })
                break
            case .greaterThanOrEqualTo(let value):
                doQuery(path: path, orderBy: orderBy, startingValue: value, endingValue: nil, observingMode: observingMode, eventType: eventType, completion: { (dict) in
                    
                    completion!(dict)
                    
                })
                break
            case .lessThan(let value):
                doQuery(path: path, orderBy: orderBy, startingValue: nil, endingValue: value.doubleValue.subtracting(1/100000000), observingMode: observingMode, eventType: eventType, completion: { (dict) in
                    
                    completion!(dict)
                    
                })
                break
            case .lessThanOrEqualTo(let value):
                doQuery(path: path, orderBy: orderBy, startingValue: nil, endingValue: value, observingMode: observingMode, eventType: eventType, completion: { (dict) in
                    
                    completion!(dict)
                    
                })
                break
            case .between(let startingValue, let endingValue):
                doQuery(path: path, orderBy: orderBy, startingValue: startingValue, endingValue: endingValue, observingMode: observingMode, eventType: eventType, completion: { (dict) in
                    
                    completion!(dict)
                    
                })
                break
            default: break
            }
        }
        
        func doQuery(path: String, orderBy: String, startingValue: Any?, endingValue: Any?, observingMode: ObservingMode, eventType: FIRDataEventType, completion:((_ snapshot: NSDictionary?) -> Void)?) {
            print(">>> where: \(orderBy) = \(startingValue) to \(endingValue)")
            // Observing
            switch observingMode {
            case .listenForChanges:
                // Between
                if startingValue != nil && endingValue != nil {
                    // Execute
                    ref.child(path).queryOrdered(byChild: orderBy).queryStarting(atValue: startingValue).queryEnding(atValue: endingValue).observe(eventType, with: { (snapshot) in
                        completion!(snapshot.value as? NSDictionary)
                    })
                }
                
                // Greater Than
                if startingValue != nil && endingValue == nil {
                    // Execute
                    ref.child(path).queryOrdered(byChild: orderBy).queryStarting(atValue: startingValue).observe(eventType, with: { (snapshot) in
                        completion!(snapshot.value as? NSDictionary)
                    })
                }

                // Less Than
                if startingValue == nil && endingValue != nil {
                    // Execute
                    ref.child(path).queryOrdered(byChild: orderBy).queryEnding(atValue: endingValue).observe(eventType, with: { (snapshot) in
                        completion!(snapshot.value as? NSDictionary)
                    })
                }
                break
            default:
                // Between
                if startingValue != nil && endingValue != nil {
                    // Execute
                    ref.child(path).queryOrdered(byChild: orderBy).queryStarting(atValue: startingValue).queryEnding(atValue: endingValue).observeSingleEvent(of: eventType, with: { (snapshot) in
                        completion!(snapshot.value as? NSDictionary)
                    })
                }
                
                // Greater Than
                if startingValue != nil && endingValue == nil {
                    // Execute
                    ref.child(path).queryOrdered(byChild: orderBy).queryStarting(atValue: startingValue).observeSingleEvent(of: eventType, with: { (snapshot) in
                        completion!(snapshot.value as? NSDictionary)
                    })
                }
                
                // Less Than
                if startingValue == nil && endingValue != nil {
                    // Execute
                    ref.child(path).queryOrdered(byChild: orderBy).queryEnding(atValue: endingValue).observeSingleEvent(of: eventType, with: { (snapshot) in
                        completion!(snapshot.value as? NSDictionary)
                    })
                }
                break
            }
        }
    }
}

