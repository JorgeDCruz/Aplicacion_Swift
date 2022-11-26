//
//  Variables.swift
//  App_Etapa3
//
//  Created by alumno on 24/11/22.
//

import Foundation
import UIKit

public struct MyVariables {
    static var isAdmin = false
    
    static func MostrarAlerta(_ titulo: String, _ mensaje: String) -> UIAlertController {
        let alert = UIAlertController(
            title: titulo,
            message: mensaje,
            preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(
            title: "Cerrar",
            style: UIAlertAction.Style.cancel))
        return alert
    }
    
    static func AvisoDePrivacidadButton() -> UIViewController {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let imageViewController = storyBoard.instantiateViewController(withIdentifier: "AvisoDePrivacidadView")
        imageViewController.modalPresentationStyle = .fullScreen
        return imageViewController
    }
    
    static func logInButton() -> UIViewController {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let imageViewController = storyBoard.instantiateViewController(withIdentifier: "LoginView")
        imageViewController.modalPresentationStyle = .fullScreen
        return imageViewController
    }
    
    static func userProfileButton() -> UIViewController {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        var identifier = "ProfileView"
        if (MyVariables.isAdmin) {
            identifier = "AdminProfileView"
        }
        let imageViewController = storyBoard.instantiateViewController(withIdentifier: identifier)
        imageViewController.modalPresentationStyle = .fullScreen
        return imageViewController
    }
    
    static func homeButton() -> UIViewController {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let imageViewController = storyBoard.instantiateViewController(withIdentifier: "LectionView")
        imageViewController.modalPresentationStyle = .fullScreen
        return imageViewController
    }
    
    static func logOutButton() -> UIViewController {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let imageViewController = storyBoard.instantiateViewController(withIdentifier: "LoginView")
        imageViewController.modalPresentationStyle = .fullScreen
        return imageViewController
    }
    
}
