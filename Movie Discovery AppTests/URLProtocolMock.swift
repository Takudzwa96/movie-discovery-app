//
//  URLProtocolMock.swift
//  Movie Discovery App
//
//  Created by Takudzwa Raisi on 2025/02/23.
//

import Foundation
import Alamofire

class URLProtocolMock: URLProtocol {
    static var responseData: Data?
    static var responseStatusCode: Int = 200
    static var responseError: Error?

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        guard let client = client else { return }

        if let error = URLProtocolMock.responseError {
            client.urlProtocol(self, didFailWithError: error)
        } else {
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: URLProtocolMock.responseStatusCode,
                httpVersion: nil,
                headerFields: nil
            )!

            client.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)

            if let data = URLProtocolMock.responseData {
                client.urlProtocol(self, didLoad: data)
            }

            client.urlProtocolDidFinishLoading(self)
        }
    }

    override func stopLoading() {}

    // Configure session for testing
    static func configureMockSession() -> Session {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolMock.self]
        return Session(configuration: configuration)
    }

    static func reset() {
        responseData = nil
        responseStatusCode = 200
        responseError = nil
    }
}
