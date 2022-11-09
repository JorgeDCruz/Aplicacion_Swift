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
    
    @IBAction func RegisterButton(_ sender: Any) {

        // Validación de usuario y contraseña
        let capitalLetterRegEx = ".*[A-Z].*"
        var textTest = NSPredicate(format: "SELF MATCHES %@", capitalLetterRegEx)
        var capitalResult = textTest.evaluate(with: contraseñaTextField.text!)
        
        if contraseñaTextField.text!.count < 8 || !capitalResult {
            let alert = UIAlertController(
                title: "Contraseña inválida",
                message: "Introduce una contraseña de al menos 8 caracteres y al menos una letra mayúscula",
                preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(
                title: "Cerrar",
                style: UIAlertAction.Style.cancel))
                    
            self.present(alert, animated: true, completion: nil)
        }
        else {
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
