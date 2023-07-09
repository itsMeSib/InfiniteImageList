//
//  NetworkManager.swift
//  NutmegBlogReader
//
//  Created by Shahzaib I. Bhatti on 04/07/2023.
//

import Foundation
import Combine

protocol NetworkManaging {
    func fetch<T: Decodable>(endpoint: Endpoint) async throws -> T
}

class NetworkManager: NetworkManaging {
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func fetch<T: Decodable>(endpoint: Endpoint) async throws -> T {
        let request = try createRequest(for: endpoint)
        let (data, _) = try await session.data(for: request)
        let decodedObject = try JSONDecoder().decode(T.self, from: data)
        return decodedObject
    }
    
    private func createRequest(for endpoint: Endpoint) throws -> URLRequest {
        var request = URLRequest(url: endpoint.url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.headers
        return request
    }
    
}
