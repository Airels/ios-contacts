//
//  ListTableViewController.swift
//  Contacts
//
//  Created by Master IDL on 17/03/2023.
//

import UIKit

class ListTableViewController: UITableViewController {
    
    
    @IBOutlet var outletTableView: UITableView!
    
    private var contacts: [Contact] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.refreshControl?.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        refresh(sender: self.tableView)
    }
    
    @objc func refresh(sender: Any?) {
        let config = URLSessionConfiguration.default
        config.allowsCellularAccess = true
        let session = URLSession(configuration: config)
        let url = URL(string: "https://contacts.education.craftedbits.io/contacts")!
        var req = URLRequest(url: url)
        req.httpMethod = "GET"
        req.addValue("Guillaume", forHTTPHeaderField: "Contacts-Owner")
        
        let task = URLSession.shared.dataTask(with: req) { (data, res, err) in
            let httpResponse = res as! HTTPURLResponse
            
            if (httpResponse.statusCode == 200) {
                do {
                    self.contacts = try JSONDecoder().decode([Contact].self, from: data!)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.refreshControl?.endRefreshing()
                    }
                } catch {
                    print("Decoding Error")
                }
            } else {
                print("\(httpResponse.statusCode) Error")
            }
        }
        
        task.resume()
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return contacts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTable", for: indexPath)

        cell.textLabel?.text = contacts[indexPath.row].fullname

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
                
        if let destination = segue.destination as? DetailViewController {
            destination.contact = contacts[outletTableView.indexPathForSelectedRow!.row]
        }
    }

}
