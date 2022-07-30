//
//  Game.swift
//  SwiftyAppStore
//
//  Created by Mico Infante on 7/30/22.
//

import Foundation

struct Game: Identifiable, Hashable {
    var id = UUID().uuidString
    var appName: String
    var appDescription: String
    var appLogo: String
    var bannerTitle: String
    var platformTitle: String
    var artwork: String

    static func == (lhs: Game, rhs: Game) -> Bool {
        return lhs.id == rhs.id
    }

    
}

