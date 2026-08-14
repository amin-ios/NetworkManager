//
//  MultipartFormData.swift
//  NetworkManager
//
//  Created by Amin on 14/08/2026.
//

import Foundation

public struct MultipartFormData {
    public let name: String
    public let data: Data
    public let mimeType: String

    public init(name: String, data: Data, mimeType: String) {
        self.name = name
        self.data = data
        self.mimeType = mimeType
    }
}
