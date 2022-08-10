//
//  MockedData.swift
//  SwiftyAppStoreTests
//
//  Created by Mico Infante on 8/10/22.
//

import Foundation
@testable import SwiftyAppStore

extension StoreApp {
    static let mockedData: [StoreApp] = [
        StoreApp(id: "1", name: "appName1", appDescription: "appDescription1", logoURL: "https://picsum.photos/200/300", bannerTitle: "bannerTitle1", platformTitle: "platformTitle1", artworkURL: "https://picsum.photos/200/300", createdAt: Date(), modifiedAt: Date()),
        StoreApp(id: "2", name: "appName2", appDescription: "appDescription2", logoURL: "https://picsum.photos/200/300", bannerTitle: "bannerTitle2", platformTitle: "platformTitle2", artworkURL: "https://picsum.photos/200/300", createdAt: Date(), modifiedAt: Date()),
        StoreApp(id: "3", name: "appName3", appDescription: "appDescription3", logoURL: "https://picsum.photos/200/300", bannerTitle: "bannerTitle3", platformTitle: "platformTitle3", artworkURL: "https://picsum.photos/200/300", createdAt: Date(), modifiedAt: Date())
    ]
}

extension StoreApp.ExtraDetail {
    static let mockedData: [StoreApp.ExtraDetail] = [
        StoreApp.ExtraDetail(about: "about1", memory: "1.5GB", updates: "New Version 1.1", rating: "4.5", description: "Some Description1"),
        StoreApp.ExtraDetail(about: "about2", memory: "2.5GB", updates: "New Version 1.2", rating: "4.6", description: "Some Description2"),
        StoreApp.ExtraDetail(about: "about3", memory: "3.5GB", updates: "New Version 1.3", rating: "4.7", description: "Some Description3")
    ]
}
