//
//  KeychainHelper.swift
//  Movie Discovery App
//
//  Created by Takudzwa Raisi on 2025/02/22.
//

import Security
import Foundation

class KeychainHelper {
    // MARK: - Singleton Instance

    /// Shared instance for global access to KeychainHelper
    static let shared = KeychainHelper()

    // MARK: - Save Data to Keychain

    /// Saves a string value securely to the Keychain.
    /// - Parameters:
    ///   - value: The string data to be securely stored.
    ///   - key: A unique key (identifier) for retrieving the stored value later.
    func save(_ value: String, forKey key: String) {
        if let data = value.data(using: .utf8) {
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: key,
                kSecValueData as String: data
            ]
            SecItemDelete(query as CFDictionary) 
            SecItemAdd(query as CFDictionary, nil)
        }
    }

    // MARK: - Read Data from Keychain

    /// Reads a stored string value from the Keychain.
    /// - Parameter key: The unique key used to retrieve the stored data.
    /// - Returns: The retrieved string if found, otherwise `nil`.
    func read(forKey key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

        if status == errSecSuccess, let data = dataTypeRef as? Data {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
    
    // MARK: - Delete Data from Keychain

    /// Deletes a stored value from the Keychain.
    /// - Parameter key: The unique key corresponding to the data to be deleted.
    func delete(forKey key: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
        SecItemDelete(query as CFDictionary)
    }
}
