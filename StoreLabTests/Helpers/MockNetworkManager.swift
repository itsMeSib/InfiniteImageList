//
//  MockNetworkManager.swift
//  StoreLabTests
//
//  Created by Shahzaib I. Bhatti on 08/07/2023.
//

import Foundation
@testable import StoreLab

class MockNetworkManager: NetworkManaging {
    let error: Error?
    
    var fetchPostsCalled = false
    
    init(error: Error? = nil) {
        self.error = error
    }
    
    func fetch<T: Decodable>(endpoint: Endpoint) async throws -> T {
        if let error = error {
            throw error
        } else {
            let endPointPath = endpoint.path.getPath
            if  endPointPath == "/v2/list" {
                fetchPostsCalled = true
                let jsonData = MockData.images.data(using: .utf8)!
                return try JSONDecoder().decode([ImageModel].self, from: jsonData) as! T
            } else {
                throw NetworkError.invalidEndpoint
            }
        }
    }
}
