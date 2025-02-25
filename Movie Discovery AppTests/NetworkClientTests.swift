//
//  NetworkClientTests.swift
//  Movie Discovery App
//
//  Created by Takudzwa Raisi on 2025/02/23.
//

import XCTest
import Alamofire
@testable import Movie_Discovery_App

final class NetworkClientTests: XCTestCase {

    var movieService: MovieServices!

    override func setUp() {
        super.setUp()
        let mockSession = URLProtocolMock.configureMockSession()
        let mockAPIClient = APIClient(session: mockSession)
        movieService = MovieServices(apiClient: mockAPIClient)
    }

    override func tearDown() {
        URLProtocolMock.reset()
        movieService = nil
        super.tearDown()
    }

    func testFetchPopularMoviesSuccess() {
        let expectation = self.expectation(description: "Fetch popular movies should succeed")

        let mockResponse = """
        {
            "results": [
                { "id": 950396, "title": "The Gorge" },
                { "id": 762509, "title": "Mufasa: The Lion King" }
            ]
        }
        """.data(using: .utf8)
        URLProtocolMock.responseData = mockResponse
        URLProtocolMock.responseStatusCode = 200

        movieService.fetchPopularMovies { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.results.count, 20)
                XCTAssertEqual(response.results.first?.title, "The Gorge")
                expectation.fulfill()
            case .failure:
                XCTFail("Expected success but got failure")
            }
        }

        waitForExpectations(timeout: 2, handler: nil)
    }

    func testFetchMovieDetails() {
        let expectation = self.expectation(description: "Fetch movie details should succeed")

        // Mock JSON response
        let mockResponse = """
        {
            "id": 1,
            "title": "Mock Movie Title",
            "overview": "This is a mock movie overview."
        }
        """.data(using: .utf8)
        URLProtocolMock.responseData = mockResponse
        URLProtocolMock.responseStatusCode = 200

        movieService.fetchMovieDetails(movieId: "1249289") { result in
            switch result {
            case .success(let movie):
                XCTAssertEqual(movie.title, "Alarum")
                XCTAssertEqual(movie.overview, "Two married spies caught in the crosshairs of an international intelligence network will stop at nothing to obtain a critical asset. Joe and Lara are agents living off the grid whose quiet retreat at a winter resort is blown to shreds when members of the old guard suspect the two may have joined an elite team of rogue spies, known as Alarum.")
                expectation.fulfill()
            case .failure:
                XCTFail("Expected success but got failure")
            }
        }

        waitForExpectations(timeout: 2, handler: nil)
    }
}
