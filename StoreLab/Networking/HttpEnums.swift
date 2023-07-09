//
//  HttpEnums.swift
//  NutmegBlogReader
//
//  Created by Shahzaib I. Bhatti on 05/07/2023.
//

import Foundation


enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    // Add other HTTP methods as needed
}

/// Enum of Network Errors
enum NetworkError: Error {
    /// No data received from the server.
    case noData
    /// The server response was unauthorized.
    case unauthorized(String?)
    /// The server response was validation error.
    case validation(String?)
    /// The server status code did not reciever.
    case nonSuccessStatusCode
    /// The server response was invalid (unexpected format).
    case invalidResponse
    /// The request was rejected: 400-499
    case badRequest
    /// Encoutered a server error.
    case serverError
    /// There was an error parsing the data.
    case parseError(String?)
    /// Unknown error.
    case unknown
    /// Invalid Endpoint .
    case invalidEndpoint
}
