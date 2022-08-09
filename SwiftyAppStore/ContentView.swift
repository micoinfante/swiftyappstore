//
//  ContentView.swift
//  SwiftyAppStore
//
//  Created by Mico Infante on 7/30/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .preferredColorScheme(.dark)
                .tabItem {
                Label("Today", systemImage: "doc.text.image").foregroundColor(.primary)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
