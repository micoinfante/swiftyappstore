//
//  StoreApp.swift
//  SwiftyAppStore
//
//  Created by Mico Infante on 7/30/22.
//


import Foundation

// MARK: - StoreApp
struct StoreApp: Codable, Identifiable {
    let id: String
    let name: String
    let appDescription: String
    let logoURL: String
    let bannerTitle: String
    let platformTitle: String
    let artworkURL: String
    let createdAt: Date
    let modifiedAt: Date

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case appDescription
        case logoURL
        case bannerTitle
        case platformTitle
        case artworkURL
        case createdAt
        case modifiedAt
    }
}

// MARK: App convenience initializers and mutators

extension StoreApp: Hashable {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(StoreApp.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        id: String? = nil,
        name: String? = nil,
        appDescription: String? = nil,
        logoURL: String? = nil,
        bannerTitle: String? = nil,
        platformTitle: String? = nil,
        artworkURL: String? = nil,
        extraDetail: ExtraDetail? = nil,
        createdAt: Date? = nil,
        modifiedAt: Date? = nil
    ) -> StoreApp {
        return StoreApp(
            id: id ?? self.id,
            name: name ?? self.name,
            appDescription: appDescription ?? self.appDescription,
            logoURL: logoURL ?? self.logoURL,
            bannerTitle: bannerTitle ?? self.bannerTitle,
            platformTitle: platformTitle ?? self.platformTitle,
            artworkURL: artworkURL ?? self.artworkURL,
            createdAt: createdAt ?? self.createdAt,
            modifiedAt: modifiedAt ?? self.modifiedAt
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }

    // MARK: - ExtraDetail
    struct ExtraDetail: Codable {
        let about: String
        let memory: String
        let updates: String
        let rating: String

        enum CodingKeys: String, CodingKey {
            case about
            case memory
            case updates
            case rating
        }
    }
}

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

extension Encodable {
    func encode() -> Data? {
        do {
            return try JSONEncoder().encode(self)
        } catch {
            return nil
        }
    }
}
