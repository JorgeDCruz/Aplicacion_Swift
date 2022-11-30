//
//  ExamController.swift
//  SignLanguage
//
//  Created by Alumno on 15/11/22.
//

import UIKit
import Firebase

class ExamController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var ExamTable: UITableView!
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Settings.instance.lectionTotal
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Cada leccion cuenta con un examen de vocabulario y uno de X
        // if ((row % 2) == 0) {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExamVocabTableViewCell.identifier, for: indexPath) as! ExamVocabTableViewCell
            
        let db = Firestore.firestore()
        let user = Auth.auth().currentUser?.uid ?? ""
        let docRef = db.collection("users").document(user)
            
        // Se lee el documento de la BD
        docRef.getDocument { (document, error) in
            guard let document = document, document.exists else {
                return
            }
            let dataDescription = document.data()
                
            // Se obtiene la calificacion del usuario en el examen
            let lection = indexPath.section + 1
            let attribute = "examvocab" + String(lection)
            let score = dataDescription?[attribute] as? Int ?? 0
                
            // Se configura la celda
            cell.configure(score, lection)
            cell.delegate = self
        }
            
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let title = "Lección " + String(section + 1)
        return title
    }
    
    @IBAction func LogOutButton(_ sender: Any) {
        self.present(MyVariables.logOutButton(), animated: true)
    }
    
    
    @IBAction func HomeButton(_ sender: Any) {
        self.present(MyVariables.homeButton(), animated: true)
    }
    
    
    @IBAction func ProfileButton(_ sender: Any) {
        self.present(MyVariables.userProfileButton(), animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ExamTable.register(ExamVocabTableViewCell.nib(), forCellReuseIdentifier: ExamVocabTableViewCell.identifier)
        ExamTable.dataSource = self
    }
    
}

extension ExamController : ExamVocabTableViewCellDelegate {
    
    func didTapButton(with lection : Int) {
        // Test
        print("\(lection)")
        
        // La leccion se configura en el controller para leer el examen correspondiente en la BD
        Settings.instance.lectionNumber = lection
        
        // Cambio de vista a ExamVocabularyViewController
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let imageViewController = storyBoard.instantiateViewController(withIdentifier: "ExamVocabularyView")
        imageViewController.modalPresentationStyle = .fullScreen
        self.present(imageViewController, animated: true)
    }
}


