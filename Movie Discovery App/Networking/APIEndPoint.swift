//
//  APIEndPoint.swift
//  Movie Discovery App
//
//  Created by Takudzwa Raisi on 2025/02/18.
//

import Foundation
import Alamofire

enum APIEndPoint: URLRequestConvertible {
    case login(username: String, password: String) 
    case fetchPopularMovies
    case fetchMovieDetails(id: String)

    var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        case .fetchPopularMovies, .fetchMovieDetails:
            return .get
        }
    }

    var path: String {
        switch self {
        case .login:
            return "https://reqres.in/api/login"
        case .fetchPopularMovies:
            return "\(Constants.baseURL)/movie/popular?api_key=\(Constants.apiKey)"
        case .fetchMovieDetails(let id):
            return "\(Constants.baseURL)/movie/\(id)?api_key=\(Constants.apiKey)"
        }
    }

    var parameters: Parameters? {
        switch self {
        case let .login(email, password):
            return ["email": email, "password": password]
        default:
            return nil
        }
    }

    func asURLRequest() throws -> URLRequest {
       let url = try path.asURL()

       var request = URLRequest(url: url)
        request.method = method

        switch self {
        case .login:
            request = try JSONEncoding.default.encode(request, with: parameters)
        default:
            request = try JSONEncoding.default.encode(request, with: parameters)
        }
        return request
    }

}
