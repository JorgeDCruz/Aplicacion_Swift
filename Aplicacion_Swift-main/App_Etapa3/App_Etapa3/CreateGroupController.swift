//
//  CreateGroupController.swift
//  App_Etapa3
//
//  Created by alumno on 22/11/22.
//

import UIKit
import Firebase
import FirebaseFirestore

class CreateGroupController: UIViewController {
    
    
    @IBOutlet weak var nameGroupTextField: UITextField!
    
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
 
    @IBAction func CreateGroupButton(_ sender: Any) {
        let nameRegEx = "^[0-9a-zA-Z\\_@¢$¿º?¡!´ ]{3,32}$"
        let nameTest = NSPredicate(format: "SELF MATCHES %@", nameRegEx)
        let validName = nameTest.evaluate(with: nameGroupTextField.text!)
        
        if (!validName) {
            self.MostrarAlerta("Error", "Asegúrate que el nombre del grupo tenga al menos 3 caracteres, máximo 32, sin símbolos ")
        }
        else {
            let db = Firestore.firestore()
            
            // Obtener el id del usuario
            guard let userID = Auth.auth().currentUser?.uid else { self.MostrarAlerta("Error", "No se ha podido hacer la conexión con la base de datos")
                return
            }
            
            let ref = db.collection("groups")
            let aDoc = ref.document().documentID

            // Creación de grupo con administrador
            ref.document( aDoc).setData(["name": nameGroupTextField.text!,"createdOn": NSDate().timeIntervalSince1970, "admins" : [userID], "users" : [userID]]) { (error) in
                
                if error != nil {
                    // Mostrar el error
                    self.MostrarAlerta("Error", "El grupo no se ha podido crear")
                    return
                }
                self.MostrarAlerta("Éxito", "Grupo creado con éxito")
            }
            
        }
    }
    
        
        
        @IBAction func ProfileButton(_ sender: Any) {
            self.present(MyVariables.userProfileButton()   , animated: true)
            
        }
        
        @IBAction func LogOutButton(_ sender: Any) {
            self.present(MyVariables.logOutButton(), animated: true)
        }
        
        
        @IBAction func HomeButton(_ sender: Any) {
            self.present(MyVariables.homeButton(), animated: true)
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Do any additional setup after loading the view.
        }
}
