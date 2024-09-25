GitHub Search App
=================

A Swift-based GitHub Search App that allows users to search for GitHub profiles and retrieve detailed user information along with their repositories. The app leverages Combine and SwiftUI to handle data fetching, UI updates, and clean architectural principles.

## Table of Contents

- [Features](#features)
- [Architecture](#architecture)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [API Integration](#api-integration)
- [Unit Testing](#unit-testing)
- [Contributing](#contributing)
- [License](#license)
## Features
------------

- Search for GitHub users by name or keyword.
- Display a list of users matching the search query.
- Fetch and display detailed user profiles including repositories.
- Combine framework for reactive data fetching.
- Clean architecture principles with service layer abstraction.
- Error handling for failed network requests.

## Architecture
--------------

This project follows the MVVM (Model-View-ViewModel) architecture pattern and leverages Combine for reactive programming.

- **Model**: Contains the data models representing GitHub users and their repositories.
- **View**: SwiftUI views that represent the UI and update based on data from the ViewModel.
- **ViewModel**: Handles the business logic of interacting with the `GitHubAPIService` and updates the UI accordingly.
- **Service Layer**: The `GitHubAPIService` handles network requests to GitHub's API.

### Core Components:
--------------------

1. **GitHubViewModel**: Handles user search and updates the list of users.
2. **UserDetailViewModel**: Fetches detailed information about a user, including their repositories.
3. **GitHubAPIService**: Manages all API calls to GitHub.
4. **Models**: Represent GitHub entities such as users and repositories.

## Requirements
--------------

- **iOS 14.0+**
- **Xcode 13.0+**
- **Swift 5.0+**

## Installation
--------------

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/github-search-app.git
Open the project in Xcode:
bash
Copy code
cd github-search-app
open GitHubSearchApp.xcodeproj
Run the project using Xcode.
Usage
Enter a username or keyword in the search field to fetch a list of GitHub users.
Select a user to view detailed information, including their profile and repositories.
API Integration
This app uses the GitHub REST API to fetch user data. The following API endpoints are used:

Search Users:

Endpoint: /search/users?q={query}
Used to search for users based on a query string.
Get User Details:

Endpoint: /users/{username}
Fetches details about a specific user.
Get User Repositories:

Endpoint: /users/{username}/repos
Retrieves the repositories of the user, excluding forks.
Unit Testing
