//
//  LectionTableViewCell.swift
//  App_Etapa3
//
//  Created by Alumno on 24/11/22.
//

import UIKit

protocol LectionTableViewCellDelegate : AnyObject {
    func didTapButton(with lection : Int)
}

class LectionTableViewCell: UITableViewCell {

    static let identifier = "LectionTableViewCell"

    private var lection : Int = 0
    
    weak var delegate : LectionTableViewCellDelegate?
    
    static func nib() -> UINib {
        return UINib(nibName: "LectionTableViewCell", bundle: nil)
    }
    
    @IBOutlet var button : UIButton!
    
    @IBAction func didTapButton() {
        delegate?.didTapButton(with: lection)
    }
    
    func configure(_ lection : Int) {
        self.lection = lection
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        button.setTitle("Contenido de Leccion", for: .normal)
        button.setTitleColor(.black, for: .normal)
    }
}
