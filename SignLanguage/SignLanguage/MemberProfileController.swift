//
//  MemberProfileController.swift
//  SignLanguage
//
//  Created by Alumno on 28/11/22.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class MemberProfileController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastnameLabel: UILabel!
    @IBOutlet var StatusTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getData()
        StatusTable.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Settings.instance.lectionTotal
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(UINib(nibName: "MyExamsTableViewCell", bundle: nil), forCellReuseIdentifier: "MyExamsTableViewCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: MyExamsTableViewCell.identifier, for: indexPath) as! MyExamsTableViewCell
        
        let db = Firestore.firestore()
        // Obtener el documento especifico del usuario
        let user = Settings.instance.memberUID
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
    
    func getData() {
        let db = Firestore.firestore()
        
        // Obtener el documento especifico del usuario
        let user = Settings.instance.memberUID
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
        }
    }
    
    @IBAction func backToGroups(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let imageViewController = storyBoard.instantiateViewController(withIdentifier: "GroupsView")
        imageViewController.modalPresentationStyle = .fullScreen
        self.present(imageViewController, animated: true)
    }
    
}
