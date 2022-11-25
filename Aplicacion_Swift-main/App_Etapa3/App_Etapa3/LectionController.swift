//
//  LectionController.swift
//  App_Etapa3
//
//  Created by alumno on 03/11/22.
//

import UIKit

class LectionController: UIViewController, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 16
    }
    
    @IBOutlet weak var LectionTable: UITableView!
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Boton1", for: indexPath) as! LectionTable
        cell.nombreDelBoton.titleLabel?.text = "Botonaso " + String(indexPath.row)
        if indexPath.row%4 == 0{
            cell.nombreDelBoton.backgroundColor = .lightGray
            cell.nombreDelBoton.setTitle("Nivel " + String((indexPath.row / 4) + 1), for: .normal)
            cell.nombreDelBoton.setTitleColor(.white, for: .normal)
        }
        
        if indexPath.row % 4 == 1 {
            cell.nombreDelBoton.setTitle("Principiante", for: .normal)
            cell.nombreDelBoton.setTitleColor(.black, for: .normal)
        }
        
        if indexPath.row % 4 == 2 {
            cell.nombreDelBoton.setTitle("Intermedio", for: .normal)
            cell.nombreDelBoton.setTitleColor(.black, for: .normal)
            
        }
        if indexPath.row % 4 == 3 {
            cell.nombreDelBoton.setTitle("Avanzado", for: .normal)
            cell.nombreDelBoton.setTitleColor(.black, for: .normal)
        }
         
        return cell
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
        LectionTable.dataSource = self
    }
    
}
