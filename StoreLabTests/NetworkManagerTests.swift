//
//  NetworkManagerTests.swift
//  StoreLabTests
//
//  Created by Shahzaib I. Bhatti on 09/07/2023.
//

import XCTest
@testable import StoreLab

final class NetworkManagerTests: XCTestCase {
    
    var networkManager: NetworkManaging!
    
    override func setUp() {
        super.setUp()
        networkManager = NetworkManager()
    }
    
    override func tearDown() {
        networkManager = nil
        super.tearDown()
    }
    
    func testFetchImages() async throws {
        let endpoint = Endpoint(.list)
        let images: [ImageModel] = try await networkManager.fetch(endpoint: endpoint) as [ImageModel]
        
        XCTAssertFalse(images.isEmpty, "Fetched images should not be empty")
    }
    
}
