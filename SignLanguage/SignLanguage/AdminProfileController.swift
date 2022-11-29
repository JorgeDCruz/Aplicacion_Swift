//
//  AdminProfileController.swift
//  SignLanguage
//
//  Created by alumno on 23/11/22.
//

import UIKit
import Firebase
import FirebaseFirestore
class AdminProfileController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var lastnameLabel: UILabel!
    
    
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
        }
    }
    
    
    @IBAction func ExamButton(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let imageViewController = storyBoard.instantiateViewController(withIdentifier: "ExamView")
            imageViewController.modalPresentationStyle = .fullScreen
            self.present(imageViewController, animated: true)
    }
    
    @IBAction func LogOutButton(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let imageViewController = storyBoard.instantiateViewController(withIdentifier: "LoginView")
        imageViewController.modalPresentationStyle = .fullScreen
        self.present(imageViewController, animated: true)
    }
    
    @IBAction func HomeButton(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let imageViewController = storyBoard.instantiateViewController(withIdentifier: "LectionView")
        imageViewController.modalPresentationStyle = .fullScreen
        self.present(imageViewController, animated: true)
    }
    
    @IBAction func ProfileButton(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let imageViewController = storyBoard.instantiateViewController(withIdentifier: "AdminProfileView")
        imageViewController.modalPresentationStyle = .fullScreen
        self.present(imageViewController, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
