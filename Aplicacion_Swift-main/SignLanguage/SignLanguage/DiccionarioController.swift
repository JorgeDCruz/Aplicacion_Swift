//
//  DiccionarioController.swift
//  App_Etapa3
//
//  Created by Alumno on 22/11/22.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth
import FirebaseCore
class DiccionarioController: UIViewController, UITableViewDataSource{
  
    let database = Firestore.firestore()
    
    
    @IBOutlet weak var Dicctable: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            27
        }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: DiccionarioTableViewCell.identifier, for: indexPath) as! DiccionarioTableViewCell
        let documentname = "Letter" + String(indexPath.row)
        let docref = database.collection("dictionary/Alphabet/Letters").document(documentname)
        docref.getDocument { (document, error) in
            guard let document = document, document.exists else {
                return
                
            }
            let dataDescription = document.data()
            let Url = dataDescription? ["image"] as? String ?? ""
            let label = dataDescription? ["letter"] as? String ?? ""
            cell.configure(Url, label)
            
        }
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Dicctable.dataSource = self
    }
        // Do any additional setuafter loading the view.
    }
    
