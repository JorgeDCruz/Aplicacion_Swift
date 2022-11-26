//
//  LectionController.swift
//  App_Etapa3
//
//  Created by alumno on 03/11/22.
//

import UIKit
import Firebase
import FirebaseFirestore

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
        LectionTable.dataSource = self
    }
    
}
