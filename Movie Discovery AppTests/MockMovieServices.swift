//
//  MockMovieServices.swift
//  Movie Discovery App
//
//  Created by Takudzwa Raisi on 2025/02/23.
//

import Foundation
import Alamofire
@testable import Movie_Discovery_App

class MockMovieServices: MovieServices {
    var shouldSucceed = true
    var mockPopularResponse: PopularResponse?
    var mockMovieDetails: Movie?

    override func login(email: String, password: String, completion: @escaping (Result<LoginResponse, AFError>) -> Void) {
        if shouldSucceed {
            let mockResponse = LoginResponse(token: "mockToken")
            completion(.success(mockResponse))
        } else {
            let error = AFError.responseValidationFailed(reason: .unacceptableStatusCode(code: 401))
            completion(.failure(error))
        }
    }

    override func fetchPopularMovies(completion: @escaping (Result<PopularResponse, AFError>) -> Void) {
        if shouldSucceed, let response = mockPopularResponse {
            completion(.success(response))
        } else {
            let error = AFError.responseValidationFailed(reason: .unacceptableStatusCode(code: 404))
            completion(.failure(error))
        }
    }

    override func fetchMovieDetails(movieId: String, completion: @escaping (Result<Movie, AFError>) -> Void) {
        if shouldSucceed, let movie = mockMovieDetails {
            completion(.success(movie))
        } else {
            let error = AFError.responseValidationFailed(reason: .unacceptableStatusCode(code: 404))
            completion(.failure(error))
        }
    }
}

