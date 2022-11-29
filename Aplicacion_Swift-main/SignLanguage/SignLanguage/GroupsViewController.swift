//
//  GroupsViewController.swift
//  SignLanguage
//
//  Created by Alumno on 25/11/22.
//

import UIKit
import Firebase

class GroupsViewController: UIViewController, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(UINib(nibName: "GroupsTableViewCell", bundle: nil), forCellReuseIdentifier: "GroupsTableViewCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: GroupsTableViewCell.identifier, for: indexPath) as! GroupsTableViewCell
        
        return cell
    }
    

    var groupName : String = ""
    
    var groupArray : [String] = []
    
    @IBOutlet var GroupsTable : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    func getGroups() {
        let db = Firestore.firestore()
        let docRef = db.collection("groups")
        let user = Auth.auth().currentUser?.uid ?? ""
        
        
        // Encontrar todos lso documentos donde el usuario sea el admin
        var results = docRef.whereField("admins", arrayContains: user)
        
        results.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let dataDescription = document.data()
                    let groupName = dataDescription["name"]
                }
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
