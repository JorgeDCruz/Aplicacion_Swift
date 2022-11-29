//
//  SignUpController.swift
//  SignLanguage
//
//  Created by alumno on 04/11/22.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class SignUpController: UIViewController{
    
    @IBOutlet weak var correoTextField: UITextField!
    @IBOutlet weak var nombreTextField: UITextField!
    @IBOutlet weak var apellidoTextField: UITextField!
    @IBOutlet weak var contraseñaTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var switcher: UISwitch!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        //errorLabel.alpha = 0
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
    
    // Compara el contenido de la contraseña con una expresión regular, con el fin de mantener un grado de seguridad de contraseñas
    func validatePassword(_ password : String) -> Bool {
        let passwordRegEx = ".*(?=.{8,16})(?=.*[A-Z]).*"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: password)
    }
    
    // Compara el contenido del nombre con una expresión regular
    func validateName(_ name: String) -> Bool {
        let nameRegEx = "^[0-9a-zA-Z\\_]{3,16}$"
        let nameTest = NSPredicate(format: "SELF MATCHES %@", nameRegEx)
        return nameTest.evaluate(with: name)
    }
    
    // Checa los campos de texto y sus contenidos para verificar si es correcta. Si el contenido es correcto, se regresa nil. De lo contrario retorna un mensaje de error
    func validateFields() -> String? {
        // Checar que todos los campos esten llenos
        let switchState = switcher!.isOn
        if correoTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""  || nombreTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""  || apellidoTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""  ||	 contraseñaTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Favor de llenar todos los campos de texto."
        }
        if (!switchState) {
            return "Favor de aceptar los términos y condiciones"
        }
        
        // Checar que la contraseña ingresada sea segura
        let testEspacio = contraseñaTextField.text!.contains(" ")
        //let contraseñaLimpia = !.trimmingCharacters(in: .whitespacesAndNewlines)
        if testEspacio || validatePassword(contraseñaTextField.text!) == false {
            return "Introduce una contraseña de al menos 8 caracteres y máximamente 16 caracteres, al menos 1 letra mayúscula, sin espacios"
        }
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let emailTest = emailPred.evaluate(with: correoTextField.text!)
        
        if (!emailTest) {
            return "Introduce un correo electrónico válido, sin espacios"
        }
        
        // Checar el nombre y apellido del usuario
        /*let nombreLimpio = nombreTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let apellidoLimpio = apellidoTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)*/
        let testName = nombreTextField.text!.contains(" ")
        let testApellido = apellidoTextField.text!.contains(" ")
        if testName || testApellido ||  validateName(nombreTextField.text!) == false || validateName(apellidoTextField.text!) == false {
            return "Introduce un nombre o apellido de al menos 3 caracteres y máximamente 16 caracteres, sin espacios y sin símbolos"
        }
        
        return nil
    }
    
    @IBAction func RegisterButton(_ sender: Any) {
        // Validar los campos de texto
        let error = validateFields()
        
        if error != nil {
            // Hubo un error con el llenado de campos de texto, se muestra el error
            MostrarAlerta("Información inválida", error!)
        }
        
        else {
            
            // Crear versiones limpias de la informacion
            let nombre = nombreTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let apellido = apellidoTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = correoTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = contraseñaTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Se crea el usuario
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                
                // Se comprueba que no haya errores
                if err != nil {
                    // Hubo un error creando al usuario
                    self.MostrarAlerta("Error", "Se ha producido un error al crear al usuario, pruebe cambiando el correo electrónico u otros datos")
                }
                else {
                    // El usuario se creo de manera exitosa, se almacena el nombre y apellido
                    let db = Firestore.firestore()
                    
                    db.collection("users").document(result!.user.uid).setData(["firstname" : nombre, "lastname" : apellido, "uid" : result!.user.uid]) { (error) in
                        
                        if error != nil {
                            // Mostrar el error
                            self.MostrarAlerta("Error", "Los datos no se guardaron de manera adecuada")
                        }
                    }
                    
                    
                }
            }
            // Se mueve a la pantalla
            self.present(MyVariables.logInButton(), animated: true)
        }
        
        // Validar los campos
        
        // Crear el usuario
        
        /* Codigo de Mau
        var valid = true
    
        // Validación de contraseña
        let caracteresRegEx = ".*(?=.{8,16})(?=.*[A-Z]).*"
        var caracteresTest = NSPredicate(format: "SELF MATCHES %@", caracteresRegEx)
        var caracteresResult = caracteresTest.evaluate(with: contraseñaTextField.text!)
         let spaceResult = contraseñaTextField.text!.contains(" ")
        
        
        if !caracteresResult || spaceResult && valid {
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
         } */
}
    
    func showError(_ message : String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    
    @IBAction func SignInButton(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let imageViewController = storyBoard.instantiateViewController(withIdentifier: "LoginView")
        imageViewController.modalPresentationStyle = .fullScreen
        self.present(imageViewController, animated: true)
    }
    
}
