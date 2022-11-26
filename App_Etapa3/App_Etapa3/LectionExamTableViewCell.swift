//
//  LectionExamTableViewCell.swift
//  App_Etapa3
//
//  Created by Alumno on 24/11/22.
//

import UIKit

protocol LectionExamTableViewCellDelegate : AnyObject {
    func goToExam(with lection : Int)
}

class LectionExamTableViewCell: UITableViewCell {

    static func nib() -> UINib {
        return UINib(nibName: "LectionExamTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        button.setTitle("Ir a Examen", for: .normal)
        button.setTitleColor(.black, for: .normal)
    }
    
    static let identifier = "LectionExamTableViewCell"
    
    private var lection : Int = 0
    
    weak var delegate : LectionExamTableViewCellDelegate?
    
    @IBOutlet var button : UIButton!
    
    @IBAction func goToExam() {
        delegate?.goToExam(with: lection)
    }
    
    func configure(_ lection : Int) {
        self.lection = lection
    }
}
