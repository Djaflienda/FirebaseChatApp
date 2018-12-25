//
//  SignUpViewController.swift
//  FlashChat
//
//  Created by MacBook-Игорь on 24/12/2018.
//  Copyright © 2018 MacBook-Игорь. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        
        SVProgressHUD.show()
        
        guard let email = emailTextField.text, let password = passwordTextField.text else {return}
        
        Auth.auth().createUser(withEmail: email, password: password) { (authData, error) in
            
            SVProgressHUD.dismiss()
            
            if let error = error {
                print(error)
            } else {
                let chatViewController = self.storyboard?.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
                let navigationController = UINavigationController(rootViewController: chatViewController)
                self.present(navigationController, animated: true, completion: nil)
                
                self.navigationController?.popToRootViewController(animated: true)
            }

        }

    }
}

extension SignUpViewController {
    func validatePassword(_ password: String) {
        if password.count < 6 {
            
        }
    }
}
