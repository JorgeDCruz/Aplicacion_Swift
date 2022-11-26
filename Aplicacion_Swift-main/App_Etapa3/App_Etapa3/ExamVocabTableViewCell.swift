//
//  ExamVocabTableViewCell.swift
//  App_Etapa3
//
//  Created by Alumno on 22/11/22.
//

import UIKit

protocol ExamVocabTableViewCellDelegate : AnyObject {
    func didTapButton(with lection : Int)
}

class ExamVocabTableViewCell : UITableViewCell {

    static let identifier = "ExamVocabTableViewCell"
    
    private var score : Int = 0
    private var lection : Int = 0
    
    weak var delegate : ExamVocabTableViewCellDelegate?
    
    static func nib() -> UINib {
        return UINib(nibName: "ExamVocabTableViewCell", bundle: nil)
    }
    
    @IBOutlet var button : UIButton!
    @IBOutlet var scoreLabel : UILabel!
    
    @IBAction func didTapButton() {
        delegate?.didTapButton(with: lection)
    }
    
    func configure(_ score : Int, _ lection : Int) {
        self.score = score
        self.lection = lection
        scoreLabel.text = String(score)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        button.setTitle("Vocabulario", for: .normal)
        // button.setTitleColor(.link, for: .normal)
    }
}
