//
//  MovieServices.swift
//  Movie Discovery App
//
//  Created by Takudzwa Raisi on 2025/02/18.
//
import Foundation
import Alamofire

class MovieServices {
    let apiClient: APIClient

    init(apiClient: APIClient = APIClient.shared) {
        self.apiClient = apiClient
    }

    func fetchPopularMovies(completion: @escaping (Result<PopularResponse, AFError>) -> Void) {
        let endpoint = APIEndPoint.fetchPopularMovies
        apiClient.request(endpoint, completion: completion)
    }

    func fetchMovieDetails(movieId: String, completion: @escaping (Result<Movie, AFError>) -> Void) {
        let endpoint = APIEndPoint.fetchMovieDetails(id: movieId)
        apiClient.request(endpoint, completion: completion)
    }

    func login(email: String, password: String, completion: @escaping (Result<LoginResponse, AFError>) -> Void) {
        let endpoint = APIEndPoint.login(username: email, password: password)
        apiClient.request(endpoint, completion: completion)
    }
}

