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

            SomeView()
                .tabItem {
                    Label("Games", systemImage: "gamecontroller").foregroundColor(.primary)
                }

            SomeView()
                .tabItem {
                    Label("Apps", systemImage: "rectangle.on.rectangle").foregroundColor(.primary)
                }

            SomeView()
                .tabItem {
                    Label("Arcade", systemImage: "a.circle").foregroundColor(.primary)
                }

            SomeView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass").foregroundColor(.primary)
                }

        }
    }
}

struct SomeView: View {
    var body: some View {
        Text("Some View")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
