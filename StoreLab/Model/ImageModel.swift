//
//  ImageModel.swift
//  StoreLab
//
//  Created by Shahzaib I. Bhatti on 06/07/2023.
//

import Foundation

struct ImageModel: Codable, Identifiable {
    let id: String
    let author: String
    let width: Int
    let height: Int
    let url: String
    let download_url: String
}
