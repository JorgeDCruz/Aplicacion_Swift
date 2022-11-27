//
//  ExamVocabularyController.swift
//  App_Etapa3
//
//  Created by Alumno on 15/11/22.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth
import FirebaseCore

class ExamVocabularyController: UIViewController {
    
    let db = Firestore.firestore()
    var lectionNumber : Int = CurrentLection.instance.lectionNumber
    var collection : String = ""
    var questionArray = [1,2,3,4,5,6,7,8,9,10]
    
    // Variables utilizadas
    var currentQuestion = 0
    var rightAnswerPlacement:UInt32 = 0
    var points = 0
    
    @IBOutlet weak var lectionLabel: UILabel!
    @IBOutlet weak var userProgress: UIProgressView!
    @IBOutlet weak var questionCounter: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidAppear(_ animated: Bool) {
        self.collection = "exams/exam" + String(self.lectionNumber) + "/grammar"
        self.lectionLabel.text = String(self.lectionNumber)
        getQuestions()
        newQuestion()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func checkAnswer(_ sender: AnyObject) {
        
        self.userProgress.progress += 0.1
        
        if (sender.tag == Int(rightAnswerPlacement)) {
            print("RIGHT!")
            points += 10
            print(points)
        }
        else {
            print("WRONG!")
        }
        
        if (currentQuestion != 10) {
            newQuestion()
        }
    }
    
    // Se obtienen las 10 preguntas de manera aleatoria del banco de preguntas
    func getQuestions(){
        
        db.collection(collection).getDocuments() {
            (querySnapshot, err) in
            
            if let err = err {
                print("Error getting documents: \(err)")
            }
            else {
                let countQuery = querySnapshot?.count
                for i in 0...9 {
                    let num = Int.random(in:  1..<(countQuery ?? 10))
                    self.questionArray.insert(num, at: i)
                }
            }
        }
    }
    
    func newQuestion() {
        // Se desplega el numero de pregunta actual
        self.questionCounter.text = String(currentQuestion + 1)
        // Posicion de la opcion correcta
        rightAnswerPlacement = arc4random_uniform(4) + 1
        
        // Creacion de boton
        var button:UIButton = UIButton()
        
        var x = 1
        
        // Se lee el documento
        let documentName = "question" + String(self.questionArray[currentQuestion])
        let docRef = db.collection(collection).document(documentName)
        
        // Se lee el documento
        docRef.getDocument { (document, error) in
            guard let document = document, document.exists else {
                return
            }
            
            let dataDescription = document.data()
            
            // URL de la imagen
            let url = dataDescription?["image"] as? String ?? ""
            
            let imageUrl:URL = URL(string: url)!

            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageUrl)
                DispatchQueue.main.async {
                    self.image.image = UIImage(data: data!)
                }
            }
            
            // Se muestra la pregunta en pantalla
            self.questionLabel.text = dataDescription?["question"] as? String ?? ""
            
            // Se cambia el titulo del boton para representar las opciones
            for i in 1...4 {
                button = self.view.viewWithTag(i) as! UIButton
                
                if (i == Int(self.rightAnswerPlacement)) {
                    let name = dataDescription?["correctans"] as? String ?? ""
                    button.setTitle(name, for: .normal)
                }
                // Se utilizan las opciones "choice1", "choice2" y "choice3" de la BD
                else {
                    let choice = "choice" + String(x)
                    let name = dataDescription?[choice] as? String ?? ""
                    button.setTitle(name, for: .normal)
                    x += 1
                }
            }
            self.currentQuestion += 1
        }
    }
    
    func updateExamScore () {
        let attribute = "examvocab" + String(self.lectionNumber)
        
        // Se lee el documento del usuario
        let user = Auth.auth().currentUser?.uid ?? ""
        let docRef = db.collection("users").document(user)
        
        // Se lee el documento
        docRef.getDocument { (document, error) in
            guard let document = document, document.exists else {
                return
            }
            let dataDescription = document.data()
            let currentScore = dataDescription?[attribute] as? Int ?? 0
            // Test
            print("\(currentScore)")
            print("\(self.points)")
            
            // Se compara el valor actual con el valor almacenado
            if (currentScore < self.points) {
                // Se actualiza el valor en la base de datos
                self.db.collection("users").document(user).setData([attribute : self.points], merge : true) { (error) in
                    
                    if error != nil {
                        // Mostrar el error
                        // self.MostrarAlerta("Error", "Los datos no se guardaron de manera adecuada")
                    }
                }
            }
        }
    }
    
    @IBAction func examButton(_ sender: Any) {
        
        // Se actualiza el documento del usuario para actualizar el valor del examen
        updateExamScore()
        // Se muestra la vista de ExamenController
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let imageViewController = storyBoard.instantiateViewController(withIdentifier: "ExamView")
        imageViewController.modalPresentationStyle = .fullScreen
        self.present(imageViewController, animated: true)
    }
    
    
}
