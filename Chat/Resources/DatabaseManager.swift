//
//  DatabaseManager.swift
//  Chat
//
//  Created by Tomas D. De Andrade Gomes on 6/16/23.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()

}

// MARK: - Account Management

extension DatabaseManager {
    
    public func userExists(with email: String,
                           completion: @escaping((Bool) -> Void)) {
        
        database.child(email).observeSingleEvent(of: .value, with: { snapshot in
            guard snapshot.value as? String != nil else {
                completion(false)
                return
            }
            
            completion(true)
        })
        
    }
    
    /// Inserts new user to database
    public func insertUser(with user: ChatAppUser) {
        database.child(user.emailAddres).setValue([
            "first_name": user.firstName,
            "last_name": user.lastName
        ])
    }
}

struct ChatAppUser {
    let firstName: String
    let lastName: String
    let emailAddres: String
    //let profilePictureURL: String
}
