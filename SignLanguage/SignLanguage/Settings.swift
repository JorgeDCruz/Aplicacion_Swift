//
//  Settings.swift
//  SignLanguage
//
//  Created by Alumno on 28/11/22.
//

import Foundation

class Settings {
    
    static let instance = Settings()
    
    private init() {
    }
    
    var lectionNumber = 0
    
    var lectionTotal = 1

    var memberUID = ""

    var groups = [String]()

    var members = [[String]]()
}
