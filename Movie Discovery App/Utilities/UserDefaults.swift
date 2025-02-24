//
//  UserDefaults.swift
//  Movie Discovery App
//
//  Created by Takudzwa Raisi on 2025/02/22.
//

import Foundation

extension UserDefaults {
    private enum Keys {
        static let isLoggedIn = "isLoggedIn"
    }

    var isLoggedIn: Bool {
        get { bool(forKey: Keys.isLoggedIn) }
        set { set(newValue, forKey: Keys.isLoggedIn) }
    }
}
