//
//  SignUpController.swift
//  App_Etapa3
//
//  Created by alumno on 04/11/22.
//

import UIKit

class SignUpController: UIViewController{
    
    @IBOutlet weak var usuarioTextField: UITextField!
    @IBOutlet weak var contraseñaTextField: UITextField!
    
    func MostrarAlerta(titulo: String, mensaje: String) {
            let alert = UIAlertController(
                        title: titulo,
                        message: mensaje,
                        preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(
                title: "Cerrar",
                style: UIAlertAction.Style.cancel))
            
            self.present(alert, animated: true, completion: nil)
        }
    
    @IBAction func RegisterButton(_ sender: Any) {
        var valid = true
    
        // Validación de contraseña
        let caracteresRegEx = ".*(?=.{8,16})(?=.*[A-Z]).*"
        var caracteresTest = NSPredicate(format: "SELF MATCHES %@", caracteresRegEx)
        var caracteresResult = caracteresTest.evaluate(with: contraseñaTextField.text!)
        
        
        if !caracteresResult && valid {
            valid = false
            MostrarAlerta(titulo: "Contraseña inválida", mensaje: "Introduce una contraseña de al menos 8 caracteres y máximamente 16 caracteres, al menos 1 letra mayúscula, sin espacios")
        }
        
        // Validación usuario
        let caracteresUsuarioRegEx = "^[0-9a-zA-Z\\_]{3,16}$"
        caracteresTest = NSPredicate(format: "SELF MATCHES %@", caracteresUsuarioRegEx)
        caracteresResult = caracteresTest.evaluate(with: usuarioTextField.text!)
        if (!caracteresResult && valid) {
            valid = false
            MostrarAlerta(titulo: "Usuario inválido", mensaje: "Introduce un usuario de al menos 3 caracteres y máximamente 16 caracteres, sin espacios y sin símbolos")
        }
        
        // Verificación de validaciones
        if (valid) {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let imageViewController = storyBoard.instantiateViewController(withIdentifier: "CompanyView")
            imageViewController.modalPresentationStyle = .fullScreen
            self.present(imageViewController, animated: true)
    }
}
    
    
    @IBAction func SignInButton(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let imageViewController = storyBoard.instantiateViewController(withIdentifier: "LoginView")
        imageViewController.modalPresentationStyle = .fullScreen
        self.present(imageViewController, animated: true)
    }
    override func viewDidLoad(){
        super.viewDidLoad()
    }
}
