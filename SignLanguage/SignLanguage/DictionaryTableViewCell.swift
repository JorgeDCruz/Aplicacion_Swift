//
//  DictionaryTableViewCell.swift
//  SignLanguage
//
//  Created by Alumno on 24/11/22.
//

import UIKit

protocol DictionaryTableViewCellDelegate : AnyObject {
    func goToDictionary(with lection : Int)
}

class DictionaryTableViewCell: UITableViewCell {

    static let identifier = "DictionaryTableViewCell"
    
    private var lection : Int = 0
    
    weak var delegate : DictionaryTableViewCellDelegate?

    static func nib() -> UINib {
        return UINib(nibName: "DictionaryTableViewCell", bundle: nil)
    }
    
    @IBOutlet var button : UIButton!
    
    @IBAction func goToDictionary() {
        delegate?.goToDictionary(with: lection)
    }
    
    func configure(_ lection : Int) {
        self.lection = lection
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        button.setTitle("Glosario", for: .normal)
        button.setTitleColor(.black, for: .normal)
    }
}
