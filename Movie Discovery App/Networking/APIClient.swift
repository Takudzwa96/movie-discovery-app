//
//  APIClient.swift
//  Movie Discovery App
//
//  Created by Takudzwa Raisi on 2025/02/18.
//

import Foundation
import Alamofire

class APIClient {

    // MARK: - Singleton Instance

    /// Shared instance of `APIClient` for global access.
    static let shared = APIClient()

    private let session: Session

    init(session: Session = AF) {
        self.session = session
    }

    /// Sends a network request and decodes the response into a specified type.
    ///
    /// - Parameters:
    ///   - urlConvertible: A type that conforms to `URLRequestConvertible` to define the request.
    ///   - completion: A closure that returns a `Result` containing either the decoded object or an `AFError`.
    ///
    /// - Usage:
    /// Call this method to make network requests and automatically decode JSON responses into Swift models.
    func request<T: Decodable>(_ urlConvertible: URLRequestConvertible, completion: @escaping (Result<T, AFError>) -> Void) {
        AF.request(urlConvertible)
            .validate()
            .responseDecodable(of: T.self) { response in
                completion(response.result)
            }
    }

}
