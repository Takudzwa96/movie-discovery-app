
# Movie Discovery App

## Overview

The **Movie Discovery App** is an iOS application that allows users to browse popular movies, view movie details, and watch trailers. It features a secure login system using a mock API and follows the MVVM architecture with best practices.

## Features

- Secure Login using Reqres API
- Popular Movies list with search functionality
- Detailed Movie Information
- Movie Posters with Kingfisher image loading
- Clean and intuitive UI built with Storyboards and SwiftUI

## Requirements

- Xcode 14.0 or later
- iOS 15.0 or later
- Swift 5.7 or later
- Swift Package Manager for dependency management

## Setup Instructions

1. **Clone the Repository**

```bash
git clone https://github.com/Takudzwa96/movie-discovery-app.git
```

2. **Install Dependencies**

Using Swift Package Manager:
- Open the project in Xcode.
- Go to **File > Add Packages**.
- Search for and add the following libraries:
  - `Alamofire`
  - `Kingfisher`

3. **API Configuration**

The app uses [Reqres](https://reqres.in/) for mock login. No API key configuration is required.

4. **Build and Run**

- Open the `MovieDiscoveryApp.xcodeproj` in Xcode.
- Set the build target to a simulator or a connected device.
- Press `Cmd + R` to build and run the app.

## Usage

1. Launch the app.
2. Log in using mock credentials:
   - **Email:** `eve.holt@reqres.in`
   - **Password:** `cityslicka`
3. Browse through popular movies and view detailed information.

## Running Tests

To run unit tests:

1. Open Xcode and select **Product > Test** (or press `Cmd + U`).

## Troubleshooting

- Ensure you have a stable internet connection for API calls.
- Clean build folder if you encounter build issues: **Product > Clean Build Folder**.

