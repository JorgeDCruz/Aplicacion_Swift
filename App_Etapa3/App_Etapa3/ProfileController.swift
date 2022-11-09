//
//  ProfileController.swift
//  App_Etapa3
//
//  Created by alumno on 04/11/22.
//

import UIKit

class ProfileController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
}
