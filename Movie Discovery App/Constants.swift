//
//  Constants.swift
//  Movie Discovery App
//
//  Created by Takudzwa Raisi on 2025/02/18.
//

import Foundation

struct Constants {
    static var apiKey: String {
        return Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String ?? ""
    }
    static var baseURL: String {
        return Bundle.main.object(forInfoDictionaryKey: "baseURL") as? String ?? ""
    }
    static var imageBaseURL: String {
        return Bundle.main.object(forInfoDictionaryKey: "imageBaseURL") as? String ?? ""
    }
}

