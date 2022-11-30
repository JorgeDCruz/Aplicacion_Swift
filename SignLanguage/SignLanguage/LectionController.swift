//
//  LectionController.swift
//  SignLanguage
//
//  Created by alumno on 03/11/22.
//

import UIKit
import Firebase

class LectionController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var LectionTable: UITableView!
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Settings.instance.lectionTotal
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let title = "Lección " + String(section + 1)
        return title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row % 2 == 0 {
            
            tableView.register(UINib(nibName: "DictionaryTableViewCell", bundle: nil), forCellReuseIdentifier: "DictionaryTableViewCell")
            let cellDictionary = tableView.dequeueReusableCell(withIdentifier: DictionaryTableViewCell.identifier, for: indexPath) as! DictionaryTableViewCell
            
            // Se obtiene el numero de la leccion
            let lection = indexPath.section + 1
            cellDictionary.configure(lection)
            cellDictionary.delegate = self
            
            return cellDictionary
        }
        
        // Celda para el boton de glosario - redirige al diccionario de la leccion
        if indexPath.row % 2 == 1 {
            
            tableView.register(UINib(nibName: "LectionExamTableViewCell", bundle: nil), forCellReuseIdentifier: "LectionExamTableViewCell")
            let cellExam = tableView.dequeueReusableCell(withIdentifier: LectionExamTableViewCell.identifier, for: indexPath) as! LectionExamTableViewCell
            
            // Se obtiene el numero de la leccion
            let lection = indexPath.section + 1
            cellExam.configure(lection)
            cellExam.delegate = self
            
            return cellExam
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: LectionTableViewCell.identifier, for: indexPath) as! LectionTableViewCell
        
        return cell
    }
    
    func setLectionCount() {
        let db = Firestore.firestore()
        db.collection("lections").getDocuments() {
            (querySnapshot, err) in
            
            if let err = err {
                print("Error getting documents: \(err)")
            }
            else {
                let countQuery = querySnapshot?.count ?? 0
                Settings.instance.lectionTotal = countQuery
            }
        }
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
        setLectionCount()

        // print("\(self.count)")
        LectionTable.dataSource = self
    }
    
}

extension LectionController : DictionaryTableViewCellDelegate {
    func goToDictionary(with lection: Int) {
        // La leccion se configura en el controller para leer el examen correspondiente en la BD
        Settings.instance.lectionNumber = lection
        
        // Cambio de vista a ExamVocabularyViewController
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let imageViewController = storyBoard.instantiateViewController(withIdentifier: "DiccionarioView")
        imageViewController.modalPresentationStyle = .fullScreen
        self.present(imageViewController, animated: true)
    }
}

extension LectionController : LectionExamTableViewCellDelegate {
    func goToExam(with lection: Int) {
        // La leccion se configura en el controller para leer el examen correspondiente en la BD
        Settings.instance.lectionNumber = lection
        
        // Cambio de vista a ExamVocabularyViewController
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let imageViewController = storyBoard.instantiateViewController(withIdentifier: "ExamVocabularyView")
        imageViewController.modalPresentationStyle = .fullScreen
        self.present(imageViewController, animated: true)
    }
}


