//
//  JoinGroupController.swift
//  App_Etapa3
//
//  Created by alumno on 24/11/22.
//

import UIKit

class JoinGroupController: UIViewController {

    @IBOutlet weak var codeGroupTextField: UITextField!
    
    @IBAction func JoinGroupButton(_ sender: Any) {
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
