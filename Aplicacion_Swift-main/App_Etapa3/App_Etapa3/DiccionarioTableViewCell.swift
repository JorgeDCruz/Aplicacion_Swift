//
//  DiccionarioTableViewCell.swift
//  App_Etapa3
//
//  Created by Alumno on 24/11/22.
//

import UIKit

class DiccionarioTableViewCell: UITableViewCell {
    
    static let identifier = "cell"
    static func nib() -> UINib {
        return UINib(nibName: "DiccionarioTableViewCell", bundle: nil)
    }
    @IBOutlet weak var letra: UIImageView!
    @IBOutlet var label: UILabel!
    
   
    
    
    func configure(_ url : String, _ label : String) {
        self.label.text = label
        let imageURL:URL = URL(string   : url)!
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: imageURL)
            DispatchQueue.main.async {
                self.letra.image = UIImage(data: data!)
                
            }
            
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
