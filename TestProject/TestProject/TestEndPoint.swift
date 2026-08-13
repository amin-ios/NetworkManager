//
//  File.swift
//  NetworkManager
//
//  Created by Amin on 1/27/25.
//

import Foundation
import NetworkManager

enum TestEndPoint {
    case fetchImages
}

extension TestEndPoint: EndPoint {
    var base: String {
        "https://picsum.photos"
    }
    
    var path: String {
        switch self {
            case .fetchImages:
                "/200/300"
        }
    }
    
    var header: HTTPHeaders? {
        nil
    }
    
    var parameters: Parameters? {
        nil
    }
    
    var method: HTTPMethods {
        .get
    }
    
    var encoding: Encoding {
        .URLEncoding
    }
}
