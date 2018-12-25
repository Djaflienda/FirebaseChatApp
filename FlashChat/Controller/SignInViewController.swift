//
//  SignInViewController.swift
//  FlashChat
//
//  Created by MacBook-Игорь on 24/12/2018.
//  Copyright © 2018 MacBook-Игорь. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class SignInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        
        SVProgressHUD.show()
        
        guard let email = emailTextField.text, let password = passwordTextField.text else {return}

        Auth.auth().signIn(withEmail: email, password: password) { (authData, error) in
            
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
