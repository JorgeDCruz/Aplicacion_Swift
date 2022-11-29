//
//  ConfigureViewController.swift
//  SignLanguage
//
//  Created by alumno on 22/11/22.
//

import UIKit
import Firebase
import FirebaseFirestore

class ConfigureGroupController: UIViewController {

    @IBOutlet weak var nameGroupLabel: UILabel!
    @IBOutlet weak var newNameGroupTextField: UITextField!
    
    func MostrarAlerta(_ titulo: String, _ mensaje: String) {
        let alert = UIAlertController(
            title: titulo,
            message: mensaje,
            preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(
            title: "Cerrar",
            style: UIAlertAction.Style.cancel))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func ChangeNameGroupButton(_ sender: Any) {
        let nameRegEx = "^[0-9a-zA-Z\\_@¢$¿º?¡!´ ]{3,32}$"
        let nameTest = NSPredicate(format: "SELF MATCHES %@", nameRegEx)
        let validName = nameTest.evaluate(with: newNameGroupTextField.text!)
        
        if (!validName) {
            self.MostrarAlerta("Error", "Asegúrate que el nombre del grupo tenga al menos 3 caracteres, máximo 32, sin símbolos ")
        }
        else {
            let db = Firestore.firestore()
            
            guard let userID = Auth.auth().currentUser?.uid else { self.MostrarAlerta("Error", "No se ha podido hacer la conexión con la base de datos")
                return
            }
            
            // Obtiene document id
            db.collection("groups").whereField("admins", arrayContains: userID).getDocuments() { (querySnapshot, error) in
                
                if error != nil {
                    self.MostrarAlerta("Error", "No se ha podido hacer la conexión con la base de datos")
                    return
                } else {
                    var docID = ""
                    for document in querySnapshot!.documents {
                        // Si hace match con varios documentos, es necesario tener un array
                        docID = document.documentID
                    }
                    // Cambia nombre a grupo
                    db.collection("groups").document( docID).setData(["name": self.newNameGroupTextField.text!]) { (error) in
                        
                        if error != nil {
                            // Mostrar el error
                            self.MostrarAlerta("Error", "El grupo no se ha podido crear")
                            return
                        }
                    }
                }
            }
        }
    
    }
   
    @IBAction func ProfileButton(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let imageViewController = storyBoard.instantiateViewController(withIdentifier: "ProfileView")
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
