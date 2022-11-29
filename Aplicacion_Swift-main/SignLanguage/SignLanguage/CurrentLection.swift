//
//  CurrentLection.swift
//  SignLanguage
//
//  Created by Alumno on 23/11/22.
//

import Foundation

class CurrentLection {
    
    static let instance = CurrentLection()
    
    private init() {
    }
    
    var lectionNumber = 0
    
    var lectionTotal = 1
}
