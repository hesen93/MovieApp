//
//  AuthController.swift
//  TheMovieApp
//
//  Created by ferid on 19.02.25.
//

import UIKit

class AuthController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func buttonAction(_ sender: Any) {
        guard let email = emailTextField.text, !email.isEmpty else {return}
        guard let password = passwordTextField.text, !password.isEmpty else {return}

        FirebaseManager.shared.enter(email: email, password: password) { errorMessage in
            if let errorMessage {
                //TODO:show error alert
                self.showAlert(message: errorMessage)
            }else {
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let sceneDelegate = windowScene.delegate as? SceneDelegate {
                    sceneDelegate.tabbarRoot(windowScene:windowScene )
                }
            }
        }
            
    }
    
    

}
