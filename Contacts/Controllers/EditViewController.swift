//
//  EditViewController.swift
//  Contacts
//
//  Created by Master IDL on 17/03/2023.
//

import UIKit

class EditViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var firstnameField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var genderField: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onEndEditing(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func onSaveButton(_ sender: Any) {
        do {
            let contact = Contact(id: nil, firstname: firstnameField.text!, lastname: nameField.text!, phone: phoneField.text!, email: emailField.text!, photo: nil, gender: Gender(rawValue: genderField.selectedSegmentIndex))
            
            let config = URLSessionConfiguration.default
            config.allowsCellularAccess = true
            let session = URLSession(configuration: config)
            let url = URL(string: "https://contacts.education.craftedbits.io/contacts")!
            var req = URLRequest(url: url)
            req.httpMethod = "POST"
            req.addValue("Guillaume", forHTTPHeaderField: "Contacts-Owner")
            req.addValue("application/json", forHTTPHeaderField: "Accept")
            req.httpBody = try JSONEncoder().encode(contact)
            
            let task = URLSession.shared.dataTask(with: req) { (data, res, err) in
                let httpResponse = res as! HTTPURLResponse
                
                if (httpResponse.statusCode == 200) {
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                } else {
                    print("\(httpResponse.statusCode) Error")
                }
            }
            
            task.resume()
        } catch {
            print("Encoding Error")
        }
    }
}
