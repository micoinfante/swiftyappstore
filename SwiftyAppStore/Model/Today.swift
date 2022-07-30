//
//  Today.swift
//  SwiftyAppStore
//
//  Created by Mico Infante on 7/30/22.
//

import Foundation

struct Today: Identifiable {
    var id = UUID().uuidString
    var appName: String
    var appDescription: String
    var appLogo: String
    var bannerTitle: String
    var platformTitle: String
    var artwork: String
}

var todayItems: [Today] = [
    Today(appName: "LEGO Brawls", appDescription: "Bqttle with friends Online", appLogo: "logo1", bannerTitle: "SMash your rivals in Lego brawls", platformTitle: "Apple arcade", artwork: "artwork1"),
    Today(appName: "Forza Horizon", appDescription: "Racing Game", appLogo: "logo2", bannerTitle: "You're in charge of the Horizon Festival", platformTitle: "Apple Arcade", artwork: "artwork2")
]
