//
//  ChatTableViewController.swift
//  FlashChat
//
//  Created by MacBook-Игорь on 24/12/2018.
//  Copyright © 2018 MacBook-Игорь. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class ChatViewController: UIViewController {

    @IBOutlet weak var messageTextFieldViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    var messageArray = [Message]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        messageTextField.delegate = self
        
        self.title = "FlashChat"
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
        tableView.addGestureRecognizer(tapGesture)
        
        tableView.register(UINib(nibName: "IncomeMessageCell", bundle: nil), forCellReuseIdentifier: "MessageCell")
//        tableView.register(UINib(nibName: "OutcomeMessageCell", bundle: nil), forCellReuseIdentifier: "MessageCell")
        
        configureTableView()
        fetchMessages()
    }
    
    
    
    func fetchMessages() {
        
        SVProgressHUD.show()
        
        let messageDB = Database.database().reference().child("Messages")
        
        messageDB.observe(.childAdded) { (snapshot) in
            
            SVProgressHUD.dismiss()
            
            let snapshotValue = snapshot.value as! Dictionary<String,String>
            let text = snapshotValue["MessageBody"]!
            let sender = snapshotValue["Sender"]!
            
            let message = Message.init(sender: sender, messageBody: text)
            self.messageArray.append(message)
            
            self.configureTableView()
            self.tableView.reloadData()
        }
    }
    
    
    
    @IBAction func sendButtonPressed(_ sender: UIButton) {
        messageTextField.endEditing(true)
        messageTextField.isEnabled = false
        sendButton.isEnabled = false
        
        let messagesDB = Database.database().reference().child("Messages")
        let messageDictionary = ["Sender": Auth.auth().currentUser?.email,
                                 "MessageBody": messageTextField.text]
        messagesDB.childByAutoId().setValue(messageDictionary) { (error, reference) in
            if let error = error {
                print(error)
            } else {
                print("Message saved successfully!")
                self.messageTextField.isEnabled = true
                self.messageTextField.text = ""
                self.sendButton.isEnabled = true
            }
        }
    }
    
    @IBAction func logOutButtonPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            
            navigationController?.dismiss(animated: true, completion: nil)
        } catch {
            print("error, there was a problem signing out.")
        }
        
    }
    
}

//MARK: TableView DataSource and Delegate Methods
extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        if messageArray[indexPath.row].sender == Auth.auth().currentUser?.email {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! OutcomeMessageCell
//
//            cell.userNameLabel.text = messageArray[indexPath.row].sender
//            cell.messageBody.text = messageArray[indexPath.row].messageBody
//            cell.profileImage.backgroundColor = UIColor.blue
//
//            return cell
//
//        } else {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! IncomeMessageCell
//            cell.userNameLabel.text = messageArray[indexPath.row].sender
//            cell.messageBody.text = messageArray[indexPath.row].messageBody
//            cell.profileImage.backgroundColor = UIColor.red
//            return cell
//        }
    
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! IncomeMessageCell

        cell.userNameLabel.text = messageArray[indexPath.row].sender
        cell.messageBody.text = messageArray[indexPath.row].messageBody

        if cell.userNameLabel.text == Auth.auth().currentUser?.email {
            cell.profileImage.backgroundColor = UIColor.blue
        } else {
            cell.profileImage.backgroundColor = UIColor.red
        }
    
        return cell
    }
    
    func configureTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120.0
    }
}

//MARK: UITextField Delegate Methods
extension ChatViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3) {
            self.messageTextFieldViewHeightConstraint.constant = 320

            //FIX THIS BUG WITH KEYBOARD
            //HOW TO DETERMINE KEYBOARD HEIGHT????
            self.view.layoutIfNeeded()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3) {
            self.messageTextFieldViewHeightConstraint.constant = 50
            self.view.layoutIfNeeded()
        }
    }
    
    @objc
    func tableViewTapped() {
        messageTextField.endEditing(true)
    }
}


