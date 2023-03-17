//
//  DetailViewController.swift
//  Contacts
//
//  Created by Master IDL on 17/03/2023.
//

import UIKit

class DetailViewController: UIViewController {
    
    public var contact: Contact?

    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        nameLabel.text = contact?.fullname
        phoneLabel.text = contact?.phone
        emailLabel.text = contact?.email
    }
    
    @IBAction func onDelete(_ sender: Any) {
        let alert = UIAlertController(title: "Suppression contact", message: "Voulez-vous vraiment supprimer ce contact ?", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Oui", style: .destructive, handler: { action in
            let config = URLSessionConfiguration.default
            config.allowsCellularAccess = true
            let session = URLSession(configuration: config)
            let url = URL(string: "https://contacts.education.craftedbits.io/contacts")!
            var req = URLRequest(url: url)
            req.httpMethod = "DELETE"
            req.addValue("Guillaume", forHTTPHeaderField: "Contacts-Owner")
            req.url?.appendPathComponent("\(self.contact?.id)")
            
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
        }))
        
        alert.addAction(UIAlertAction(title: "Non", style: .default))
        
        self.present(alert, animated: true)
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
