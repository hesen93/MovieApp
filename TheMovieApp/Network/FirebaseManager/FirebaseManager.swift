//
//  FirebaseManager.swift
//  TheMovieApp
//
//  Created by ferid on 19.02.25.
//

import Foundation
import FirebaseAuth

class FirebaseManager {
    
    static let shared = FirebaseManager()
    
    private init() {}
    
    func enter(email:String, password: String, completion: @escaping(String?) -> Void) {
        if Auth.auth().currentUser == nil {
            signUp(email: email, password: password, completion: completion)
        } else {
            signIn(email: email, password: password, completion: completion)
        }
    }
    
    private func signUp(email:String, password: String, completion: @escaping(String?) -> Void) {
        Auth.auth().createUser(withEmail : email, password: password) { result, error in
            if let error = error {
                completion(error.localizedDescription)
            }else if let result = result {
                UserDefaults.standard.set(result.user.uid, forKey: "userId")
                completion(nil)
            }
        }
    }
    
    private func signIn(email:String, password: String, completion: @escaping(String?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(error.localizedDescription)
            }else if let result = result {
                UserDefaults.standard.set(result.user.uid, forKey: "userId")
                completion(nil)
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            
        }
    }
}
