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

var dummyText = """
DASH as fast as you can!
DODGE the oncoming trains!

Help Jake, Tricky & Fresh escape from the grumpy Inspector and his dog.

★ Grind trains with your cool crew!
★ Colorful and vivid HD graphics!
★ Hoverboard Surfing!
★ Paint powered jetpack!
★ Lightning fast swipe acrobatics!
★ Challenge and help your friends!

Join the most daring chase!

A Universal App with HD optimized graphics.

By Kiloo and Sybo.
"""
