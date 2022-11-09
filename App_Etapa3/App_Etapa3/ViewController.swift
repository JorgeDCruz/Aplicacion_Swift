//
//  ViewController.swift
//  App_Etapa3
//
//  Created by alumno on 02/11/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var usuarioTextField: UITextField!
    @IBOutlet weak var contraseñaTextField: UITextField!
    
    
    var isLoggedIn = true
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func SignUpButton(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let imageViewController = storyBoard.instantiateViewController(withIdentifier: "SignUpView")
        imageViewController.modalPresentationStyle = .fullScreen
        self.present(imageViewController, animated: true)
    }
    
    //Boton de inicio de sesion
    @IBAction func LoginButton(_ sender: Any) {
    
        if isLoggedIn == true{
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let imageViewController = storyBoard.instantiateViewController(withIdentifier: "LectionView")
            imageViewController.modalPresentationStyle = .fullScreen
            self.present(imageViewController, animated: true)
        }
        else{
            isLoggedIn = true
        }
    }
}

