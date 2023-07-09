//
//  Paths.swift
//  NutmegBlogReader
//
//  Created by Shahzaib I. Bhatti on 05/07/2023.
//

import Foundation


enum Paths {
    case list
}

extension Paths {
    var getPath: String {
        switch self {
        case .list:
            return "/v2/list"
        }
    }
}
