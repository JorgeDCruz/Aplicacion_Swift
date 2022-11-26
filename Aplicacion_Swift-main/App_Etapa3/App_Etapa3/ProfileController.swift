//
//  ProfileController.swift
//  App_Etapa3
//
//  Created by alumno on 04/11/22.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class ProfileController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastnameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getData()
    }
    
    @IBAction func GroupButton(_ sender: Any) {
        // Se mueve a la pantalla
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let joinGroupView = storyBoard.instantiateViewController(withIdentifier: "JoinGroupView")
        joinGroupView.modalPresentationStyle = .fullScreen
        self.present(joinGroupView, animated: true)
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
            

        }
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
}
