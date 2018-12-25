//
//  ViewController.swift
//  FlashChat
//
//  Created by MacBook-Игорь on 24/12/2018.
//  Copyright © 2018 MacBook-Игорь. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

//    @IBAction func signInButtonPressed(_ sender: UIButton) {
//        let signInViewController = storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
//        navigationController?.pushViewController(signInViewController, animated: true)
//    }
//
//    @IBAction func signUpButtonPressed(_ sender: UIButton) {
//        let signInViewController = storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
//        navigationController?.pushViewController(signInViewController, animated: true)
//    }
    
    
    @IBAction func singButtonPressed(_ sender: UIButton) {
        var nextViewController = UIViewController()
        
        switch sender.tag {
        case 1:
            nextViewController = storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
        case 2:
            nextViewController = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        default: break
        }
        
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    
    
}

