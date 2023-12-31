//
//  NotesData.swift
//  BeatsTest
//
//  Created by Rafa (Ruffles) on 07/11/23.
//

import Foundation
import SwiftUI

final class NotesData {
    static let notes: [Note] = [
        Note(name: "Semibreve", duration: 1, color: .yellow),
        Note(name: "Minima", duration: 1/2, color: Color(red: 0.41, green: 0.84, blue: 0.34)),
        Note(name: "Seminima", duration: 1/4, color: Color(red: 0.15, green: 0.74, blue: 1)),
        Note(name: "Colcheia", duration: 1/8, color: Color(red: 0.84, green: 0.52, blue: 0.99)),
        Note(name: "Semicolcheia", duration: 1/16, color: Color(red: 0.87, green: 0.35, blue: 0.6)),
        
        ///Inutilizadas por enquanto

        //Note(name: "Fusa", duration: 1/32),
        //Note(name: "Semifusa", duration: 1/64),
        //Note(name: "Quartifusa", duration: 1/128)
    ]
}
