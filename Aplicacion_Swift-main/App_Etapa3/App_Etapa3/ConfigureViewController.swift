//
//  ConfigureViewController.swift
//  App_Etapa3
//
//  Created by alumno on 22/11/22.
//

import UIKit
import Firebase
import FirebaseFirestore
import DropDown

var nameDocs = [String]()
var docID = [String]()
var doc = [Any]()
var indexDoc = 0

class ConfigureGroupController: UIViewController {
    
    
    @IBOutlet weak var nameGroupLabel: UILabel!
    @IBOutlet weak var titleCodeGroup: UILabel!
    @IBOutlet weak var changeTitleGroup: UILabel!
    
    @IBOutlet weak var codeGroupLabel: UILabel!
    @IBOutlet weak var newNameGroupTextField: UITextField!
    
    @IBOutlet weak var changeNameGroup: UIButton!
    @IBOutlet weak var selectGroupButton: UIButton!
    let dropDown = DropDown()
    
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
    
    @IBAction func groupSelected(_ sender: Any) {
        if (selectGroupButton.titleLabel!.text != "Elija su grupo") {
            indexDoc = nameDocs.firstIndex(of: selectGroupButton.titleLabel!.text ?? "Elija su grupo") ?? 0
            self.codeGroupLabel.text! = docID[indexDoc]
             self.nameGroupLabel.text! = nameDocs[indexDoc]
            if (self.codeGroupLabel.isHidden) {
                self.codeGroupLabel.isHidden = false
                self.nameGroupLabel.isHidden = false
                self.changeNameGroup.isHidden = false
                self.titleCodeGroup.isHidden = false
                self.newNameGroupTextField.isHidden = false
                self.changeTitleGroup.isHidden = false
            }
        }
    }
    
    @IBAction func grupoSelect(_ sender: UIButton) {
        dropDown.dataSource = nameDocs //4
            dropDown.anchorView = sender //5
            dropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height) //6
            dropDown.show() //7
            dropDown.selectionAction = { [weak self] (index: Int, item: String) in //8
              guard let _ = self else { return }
              sender.setTitle(item, for: .normal) //9
            }
        
    }
    
    @IBAction func ChangeNameGroupButton(_ sender: Any) {
        if (selectGroupButton.currentTitle == "Elija su grupo") {
            MostrarAlerta("Error", "Seleccione primero un grupo")
            return
        }
        let nameRegEx = "^[0-9a-zA-Z\\_@¢$¿º?¡!´ ]{3,32}$"
        let nameTest = NSPredicate(format: "SELF MATCHES %@", nameRegEx)
        let validName = nameTest.evaluate(with: newNameGroupTextField.text!)
        
        if (!validName) {
            self.MostrarAlerta("Error", "Asegúrate que el nombre del grupo tenga al menos 3 caracteres, máximo 32, sin símbolos ")
            return
        }
        else {
            let db = Firestore.firestore()
                    db.collection("groups").document(docID[indexDoc]).updateData(["name": self.newNameGroupTextField.text!])
                    self.MostrarAlerta("Éxito", "Nombre del grupo cambiado con éxito")
            nameDocs[indexDoc] = newNameGroupTextField.text!
                }
        self.codeGroupLabel.text! = docID[indexDoc]
         self.nameGroupLabel.text! = nameDocs[indexDoc]
        self.selectGroupButton.titleLabel!.text = nameDocs[indexDoc]
            }

    func UpdateDataInView() {
        // Carga labels correspondientes
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
                    if ((querySnapshot?.documents.isEmpty) == nil) {
                        self.MostrarAlerta("Error", "Usted no es administrador de algún grupo actualmente")
                        return
                    }
                
                for document in querySnapshot!.documents {
                    // Si hace match con varios documentos, es necesario tener un array
                    nameDocs.append(document.get("name") as! String)
                    docID.append(document.documentID)
                    doc.append(document)
                }
                // Obtiene nombre de grupo y código
               /*    self.codeGroupLabel.text! = docID[0]
                self.nameGroupLabel.text! = (doc[0] as AnyObject).get("name") as! String*/
                
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
        
        self.codeGroupLabel.isHidden = true
        self.nameGroupLabel.isHidden = true
        self.changeNameGroup.isHidden = true
        self.titleCodeGroup.isHidden = true
        self.newNameGroupTextField.isHidden = true
        self.changeTitleGroup.isHidden = true
        
        self.UpdateDataInView()
        
        
        }
        
    }

