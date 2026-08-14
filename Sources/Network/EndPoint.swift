//
//  EndPoint.swift
//
//  Created by Amin on 17/10/2023.
//

import Foundation
import OSLog

public typealias HTTPHeaders = [String: String]
public typealias Parameters = [String: Any]

public protocol EndPoint {
    var base: String { get }
    var path: String { get }
    var header: HTTPHeaders? { get }
    var parameters: Parameters? { get }
    var method: HTTPMethods { get }
    var encoding: Encoding { get }
}

public extension EndPoint {
    var urlComponents: URLComponents? {
        guard var components = URLComponents(string: base) else {
            Logger.network.warning("Invalid URL: \(base)")
            return nil
        }
        components.path = path
        return components
    }

    /// Builds the `URLRequest` for this endpoint.
    /// - Throws: `NetworkError.invalidURL` if `base`/`path` don't form a valid URL,
    ///   or `NetworkError.encodingFailed` if `parameters` can't be encoded.
    var request: URLRequest {
        get throws {
            guard let url = urlComponents?.url else {
                Logger.network.error("failed to build URL from base: \(base), path: \(path)")
                throw NetworkError.invalidURL(base + path)
            }
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = method.rawValue
            urlRequest.allHTTPHeaderFields = header

            if let parameters {
                do {
                    try encoding.encode(urlRequest: &urlRequest, with: parameters)
                } catch {
                    Logger.network.error("\(error.localizedDescription)")
                    throw error
                }
            }
            return urlRequest
        }
    }
}
