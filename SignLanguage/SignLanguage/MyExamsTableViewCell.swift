//
//  MyExamsTableViewCell.swift
//  SignLanguage
//
//  Created by Alumno on 25/11/22.
//

import UIKit

class MyExamsTableViewCell: UITableViewCell {

    static func nib() -> UINib {
        return UINib(nibName: "MyExamsTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBOutlet var lectionLabel : UILabel!
    @IBOutlet var statusLabel : UILabel!
    
    static let identifier = "MyExamsTableViewCell"
    
    func configure(_ lection : Int, _ score : Int) {
        lectionLabel.text = "Lección " + String(lection)
        
        if (score >= 70) {
            statusLabel.text = "Completado"
            statusLabel.textColor = UIColor(named: "Color")
        } else {
            statusLabel.text = "En progreso"
            statusLabel.textColor = .gray
        }
    }
}
