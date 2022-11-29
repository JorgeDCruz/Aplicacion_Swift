//
//  GroupsTableViewCell.swift
//  SignLanguage
//
//  Created by Alumno on 25/11/22.
//

import UIKit

class GroupsTableViewCell: UITableViewCell {

    static func nib() -> UINib {
        return UINib(nibName: "GroupsTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static let identifier = "GroupsTableViewCell"
    
    @IBOutlet var userName : UIButton!
    
    func configure(_ lection : Int, _ score : Int) {
        
    }
    
}
