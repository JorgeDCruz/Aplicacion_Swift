//
//  GroupsTableViewCell.swift
//  SignLanguage
//
//  Created by Alumno on 25/11/22.
//

import UIKit

protocol GroupsTableViewCellDelegate : AnyObject {
    func showProfile(with uid : String)
}

class GroupsTableViewCell: UITableViewCell {

    static func nib() -> UINib {
        return UINib(nibName: "GroupsTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static let identifier = "GroupsTableViewCell"
    
    var uid : String = ""
    
    weak var delegate : GroupsTableViewCellDelegate?
    
    @IBOutlet var userName : UIButton!
    
    func configure(_ name : String, _ userUID : String) {
        userName.setTitle(name, for: .normal)
        uid = userUID
    }
    
    @IBAction func showProfile() {
        delegate?.showProfile(with: uid)
    }
}
