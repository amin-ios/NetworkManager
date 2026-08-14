// The Swift Programming Language
// https://docs.swift.org/swift-book


import Foundation
import OSLog

extension APIClient: ModernConcurrencyAPIProtocol {
    public func execute(request endpoint: any EndPoint) async throws -> Data {
        let urlRequest = try endpoint.request
        urlRequest.log()

        do {
            let data: (data: Data, response: URLResponse) = try await session.data(for: urlRequest)
            let response = Response(response: data.response, data: data.data)
            return try handleSuccess(response: response)
        } catch {
            Logger.network.error("\(error.localizedDescription)")
            throw handle(error: error, request: urlRequest)
        }
    }
}
