//
//  LoginViewModelTests.swift
//  Movie Discovery App
//
//  Created by Takudzwa Raisi on 2025/02/23.
//

import XCTest
@testable import Movie_Discovery_App

class LoginViewModelTests: XCTestCase {
    var viewModel: LoginViewModel!
    var mockService: MockMovieServices!

    override func setUp() {
        super.setUp()
        mockService = MockMovieServices()
        viewModel = LoginViewModel()
        viewModel.movieService = mockService
    }

    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }

    func testLoginSuccess() {
        let expectation = self.expectation(description: "Login should succeed")
        mockService.shouldSucceed = true

        viewModel.onLoginSuccess = {
            expectation.fulfill()
        }

        viewModel.onLoginFailure = { _ in
            XCTFail("Login should not fail")
        }

        viewModel.login(email: "eve.holt@reqres.in", password: "cityslicka")
        waitForExpectations(timeout: 2, handler: nil)
    }

    func testLoginFailure() {
        let expectation = self.expectation(description: "Login should fail")
        mockService.shouldSucceed = false

        viewModel.onLoginFailure = { errorMessage in
            XCTAssertEqual(errorMessage, "Login failed: Response status code was unacceptable: 401.")
            expectation.fulfill()
        }

        viewModel.onLoginSuccess = {
            XCTFail("Login should not succeed")
        }

        viewModel.login(email: "takudzwa@gmail.com", password: "1234!")
        waitForExpectations(timeout: 2, handler: nil)
    }

    func testLoadingState() {
        let expectation = self.expectation(description: "Loading state should be updated correctly")
        var loadingStates = [Bool]()

        viewModel.isLoading = { isLoading in
            loadingStates.append(isLoading)
        }

        mockService.shouldSucceed = true
        viewModel.login(email: "eve.holt@reqres.in", password: "cityslicka")

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(loadingStates, [true, false]) 
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2, handler: nil)
    }

}
