//
//  AdminProfileController.swift
//  SignLanguage
//
//  Created by alumno on 23/11/22.
//

import UIKit
import Firebase
import FirebaseFirestore
class AdminProfileController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var lastnameLabel: UILabel!
    @IBOutlet weak var configureGroupButton: UIButton!
        
        @IBOutlet weak var seeGroupButton: UIButton!
    
    @IBOutlet var StatusTable: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Settings.instance.lectionTotal
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(UINib(nibName: "MyExamsTableViewCell", bundle: nil), forCellReuseIdentifier: "MyExamsTableViewCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: MyExamsTableViewCell.identifier, for: indexPath) as! MyExamsTableViewCell
        
        let db = Firestore.firestore()
        // Obtener el documento especifico del usuario
        let user = Auth.auth().currentUser?.uid ?? ""
        let docRef = db.collection("users").document(user)
        
        // Se lee el documento
        docRef.getDocument { (document, error) in
            guard let document = document, document.exists else {
                return
            }
            let dataDescription = document.data()
            let lection = indexPath.row + 1
            let attribute = "examvocab" + String(lection)
            let score = dataDescription?[attribute] as? Int ?? 0
            
            // Se configura la celda
            cell.configure(lection, score)
        }
        return cell
    }
    
    
    @IBAction func enterCreationGroup(_ sender: Any) {
        // Se mueve a la pantalla
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let createGroupView = storyBoard.instantiateViewController(withIdentifier: "CreateGroupView")
        createGroupView.modalPresentationStyle = .fullScreen
        self.present(createGroupView, animated: true)
    }
    
    @IBAction func ConfigureGroupButton(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let configureGroupView = storyBoard.instantiateViewController(withIdentifier: "ConfigureGroupView")
        configureGroupView.modalPresentationStyle = .fullScreen
        self.present(configureGroupView, animated: true)
    }
    
    func getData() {
        let db = Firestore.firestore()
                
                // Obtener el documento especifico del usuario
                let user = Auth.auth().currentUser?.uid ?? ""
                let docRef = db.collection("users").document(user)
                
                // Se lee el documento
                docRef.getDocument { (document, error) in
                    guard let document = document, document.exists else {
                        return
                    }
                    let dataDescription = document.data()
                    let name = dataDescription?["firstname"] as? String ?? ""
                    let apellido = dataDescription?["lastname"] as? String ?? ""
                    self.nameLabel.text = name
                    self.lastnameLabel.text = apellido
                    
                    // Muestra el botón de configurar grupo en caso de sí tener grupo creado
                    guard let userID = Auth.auth().currentUser?.uid else {
                        return
                    }
                    
                    db.collection("groups").whereField("admins", arrayContains: userID).getDocuments() { (querySnapshot, error) in
                        
                        if error != nil {
                            return
                        } else {
                            if (querySnapshot?.documents.count != 0) {
                                self.configureGroupButton.isHidden = false
                                self.seeGroupButton.isHidden = false
                            }
                            
                        }
                    }
                }
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
    
    @IBAction func ViewGroups(_ sender: Any) {
        if(Settings.instance.groups.isEmpty && Settings.instance.members.isEmpty) {
            getGroups()
        }
        // Pasar a la vista de grupos
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let imageViewController = storyBoard.instantiateViewController(withIdentifier: "GroupsView")
        imageViewController.modalPresentationStyle = .fullScreen
        self.present(imageViewController, animated: true)
    }
    
    @IBAction func ExamButton(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let imageViewController = storyBoard.instantiateViewController(withIdentifier: "ExamView")
            imageViewController.modalPresentationStyle = .fullScreen
            self.present(imageViewController, animated: true)
    }
    
    
    
    @IBAction func LogOutButton(_ sender: Any) {
        self.present(MyVariables.logOutButton(), animated: true)
    }
    
    @IBAction func HomeButton(_ sender: Any) {
        self.present(MyVariables.homeButton(), animated: true)
    }
    
    @IBAction func ProfileButton(_ sender: Any) {
        self.present(MyVariables.userProfileButton(), animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        configureGroupButton.isHidden = true
                seeGroupButton.isHidden = true
        StatusTable.dataSource = self

        // Do any additional setup after loading the view.
    }
}
