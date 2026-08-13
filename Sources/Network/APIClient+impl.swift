// The Swift Programming Language
// https://docs.swift.org/swift-book


import Foundation

extension APIClient: ModernConcurrencyAPIProtocol {
    public func execute(request endpoint: any EndPoint) async throws -> Data {
        guard let urlRequest = endpoint.request else {
            throw NetworkError.invalidURL(endpoint.urlComponents.string)
        }
        urlRequest.log()

        do {
            let data: (data: Data, response: URLResponse) = try await session.data(for: urlRequest)
            let response = Response(response: data.response, data: data.data)
            let dataObject = try handleSuccess(response: response)
            return dataObject
        } catch {
            throw handle(error: error, request: urlRequest)
        }
    }
}
