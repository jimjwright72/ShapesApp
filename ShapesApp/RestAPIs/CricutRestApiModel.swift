//
//  CricutRestApiModel.swift
//  ShapesApp
//
//  Created by Jimmy Wright on 7/28/25.
//

import Foundation

// MARK: - CricutButtonsResponse
struct CricutButtonsResponse: Codable {
    let buttons: [CricutButton]
}

// MARK: - CricutButton
struct CricutButton: Codable, Equatable {
    let name, drawPath: String

    enum CodingKeys: String, CodingKey {
        case name
        case drawPath = "draw_path"
    }
}
