//
//  ViewController.swift
//  App_Etapa3
//
//  Created by alumno on 02/11/22.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    @IBOutlet weak var usuarioTextField: UITextField!
    @IBOutlet weak var contraseñaTextField: UITextField!
    
    
    var isLoggedIn = true
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // Función que muestra una alerta en pantalla
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
    
    @IBAction func SignUpButton(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let imageViewController = storyBoard.instantiateViewController(withIdentifier: "SignUpView")
        imageViewController.modalPresentationStyle = .fullScreen
        self.present(imageViewController, animated: true)
    }
    
    // Checa los campos de texto. Si el contenido no es está vacío, se regresa nil. De lo contrario retorna un mensaje de error
    func validateFields() -> String? {
        // Checar que todos los campos esten llenos
        if usuarioTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""  || contraseñaTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "Favor de llenar todos los campos de texto."
        }
        return nil
    }
    
    //Boton de inicio de sesion
    @IBAction func LoginButton(_ sender: Any) {
        
        // Validar los campos de texto
        let error = validateFields()
        
        if error != nil {
            // Hubo un error con la captura de datos
            MostrarAlerta("Información incompleta", error!)
        }
        
        else {
            // Crear versiones limpias de los campos de texto
            let usuario = usuarioTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = contraseñaTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Sign in del usuario
            Auth.auth().signIn(withEmail: usuario, password: password) { (result, error) in
                
                if error != nil {
                    // No se pudo hacer un sign in correcto
                    self.MostrarAlerta("Error al hacer Log In", error!.localizedDescription)
                }
                else {
                    if self.isLoggedIn == true{
                        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                        let imageViewController = storyBoard.instantiateViewController(withIdentifier: "LectionView")
                        imageViewController.modalPresentationStyle = .fullScreen
                        self.present(imageViewController, animated: true)
                    }
                    else{
                        self.isLoggedIn = true
                    }
                }
            }
        }
    }
}

