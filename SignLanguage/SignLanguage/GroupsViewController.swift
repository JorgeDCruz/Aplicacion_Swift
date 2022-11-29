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
        Settings.instance.groups.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Settings.instance.members[section].count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let title = Settings.instance.groups[section]
        return title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(UINib(nibName: "GroupsTableViewCell", bundle: nil), forCellReuseIdentifier: "GroupsTableViewCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: GroupsTableViewCell.identifier, for: indexPath) as! GroupsTableViewCell
        
        let db = Firestore.firestore()
        let docName = Settings.instance.members[indexPath.section][indexPath.row]
        let docRef = db.collection("users").document(docName)
        
        // Se lee el documento de la BD
        docRef.getDocument { (document, error) in
            guard let document = document, document.exists else {
                return
            }
            let dataDescription = document.data()
                
            // Se obtiene el nombre del usuario
            let firstName = dataDescription?["firstname"] as? String ?? ""
            let lastName = dataDescription?["lastname"] as? String ?? ""
            let name = firstName + " " + lastName
                
            // Se configura la celda
            cell.configure(name, docName)
            cell.delegate = self
        }
        
        return cell
    }
    
    @IBOutlet var GroupsTable : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if(Settings.instance.groups.isEmpty && Settings.instance.members.isEmpty) {
            getGroups()
        }
        GroupsTable.dataSource = self
    }
    
    func getGroups() {
        let db = Firestore.firestore()
        let docRef = db.collection("groups")
        let user = Auth.auth().currentUser?.uid ?? ""
        
        
        // Encontrar todos lso documentos donde el usuario sea el admin
        let results = docRef.whereField("admins", arrayContains: user)
        
        results.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let dataDescription = document.data()
                    // Se guarda el nombre de todos los grupos encontrados
                    let groupName = dataDescription["name"]! as! String
                    Settings.instance.groups.append(groupName)
                    // Se guarda el array de los miembros de cada grupo
                    let groupMembers = dataDescription["users"]! as! [String]
                    Settings.instance.members.append(groupMembers)
                }
            }
        }
    }
    
    
    @IBAction func LogOut(_ sender: Any) {
        let imageViewController = MyVariables.logOutButton()
        self.present(imageViewController, animated: true)
    }
    
    
    @IBAction func Home(_ sender: Any) {
        let imageViewController = MyVariables.homeButton()
        self.present(imageViewController, animated: true)
    }
    
    
    @IBAction func Profile(_ sender: Any) {
        let imageViewController = MyVariables.userProfileButton()
        self.present(imageViewController, animated: true)
    }
}

extension GroupsViewController : GroupsTableViewCellDelegate {
    
    func showProfile(with uid : String) {
        
        // La leccion se configura en el controller para leer el examen correspondiente en la BD
        Settings.instance.memberUID = uid
        
        // Cambio de vista a ExamVocabularyViewController
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let imageViewController = storyBoard.instantiateViewController(withIdentifier: "MemberProfileView")
        imageViewController.modalPresentationStyle = .fullScreen
        self.present(imageViewController, animated: true)
    }
}
