//
//  JoinGroupController.swift
//  SignLanguage
//
//  Created by alumno on 24/11/22.
//

import UIKit
import Firebase
import FirebaseFirestore

var users = [String]()
class JoinGroupController: UIViewController {

    @IBOutlet weak var codeGroupTextField: UITextField!
    
    @IBAction func JoinGroupButton(_ sender: Any) {
        let nameRegEx = "^[0-9a-zA-Z]{3,32}$"
        let nameTest = NSPredicate(format: "SELF MATCHES %@", nameRegEx)
        let validName = nameTest.evaluate(with: codeGroupTextField.text!)
        
        if (!validName) {
            self.present(MyVariables.MostrarAlerta("Error", "Asegúrate de introducir un código válido"), animated: true, completion: nil)
        }
        else {
            let db = Firestore.firestore()
            
            guard let userID = Auth.auth().currentUser?.uid else { self.present(MyVariables.MostrarAlerta("Error", "No se ha podido hacer la conexión con la base de datos"), animated: true, completion: nil)
                
                return
            }
            
            // Validación de correcto código
            db.collection("groups").document(self.codeGroupTextField.text!).getDocument(completion: { document, error in
                if error != nil {
                    self.present(MyVariables.MostrarAlerta("Error", "No se ha podido establecer conexión con la base de datos"), animated: true, completion: nil)
                    return
                }
                if (document!.get("users") != nil) {
                    users = document!.get("users") as! [String]
                }
                else {
                    users = [String]()
                }
                                                                                        
            })
            if (users.isEmpty) {
                self.present(MyVariables.MostrarAlerta("Error", "Asegúrate de introducir un código válido"), animated: true, completion: nil)
                return
            }
            
            if (users.contains(userID)) {
                self.present(MyVariables.MostrarAlerta("Error", "Ya estás unido en este grupo"), animated: true, completion: nil)
                return
            }
                
                db.collection("groups").document(self.codeGroupTextField.text!).updateData(["users": FieldValue.arrayUnion([userID])]) { (error) in
                    if error != nil {
                        // Mostrar el error
                        self.present(MyVariables.MostrarAlerta("Error", "No se ha podido unir al grupo"), animated: true, completion: nil)
                        return
                    }
                        self.present(MyVariables.MostrarAlerta("Éxito", "Se ha unido al grupo con éxito"), animated: true, completion: nil)
                }
                
            }
            
    }
    
    @IBAction func ProfileButton(_ sender: Any) {
        self.present(MyVariables.userProfileButton(), animated: true)
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
