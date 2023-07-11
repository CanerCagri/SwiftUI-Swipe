//
//  CardModel.swift
//  SwiftUI-Swipe
//
//  Created by Caner Çağrı on 11.07.2023.
//

import SwiftUI

struct CardModel: Identifiable {
    var id = UUID()
    
    var name: String
    var age: Int
    var image: String
    
    var description: String {
        return name + " , " + age.description
    }
}
