//
//  ViewController.swift
//  Contacts
//
//  Created by Master IDL on 17/03/2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    private var contacts: [Contact] = []
    
    private var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        showContact(index: 0)
    }
    
    private func showContact(index: Int) {
        if (contacts.count == 0) {
            nameLabel.text = "Aucun"
            phoneLabel.text = "contact"
            emailLabel.text = ""
            return
        }
        
        let contact = contacts[index]
        
        nameLabel.text = contact.fullname
        phoneLabel.text = contact.phone
        emailLabel.text = contact.email
    }
    
    @IBAction func swipeGesture(_ sender: UISwipeGestureRecognizer) {
        currentIndex = (currentIndex + 1) % contacts.count
        showContact(index: currentIndex)
    }

    @IBAction func reverseSwipeGesture(_ sender: Any) {
        currentIndex = (currentIndex - 1) % contacts.count
        showContact(index: currentIndex)
    }
    
    @IBAction func onButtonDelete(_ sender: UIButton) {
        contacts.remove(at: currentIndex)
        
        if (contacts.count > 0) {
            currentIndex = (currentIndex - 1) % contacts.count
        } else {
            sender.isEnabled = false
        }
        
        showContact(index: currentIndex)
    }
}

