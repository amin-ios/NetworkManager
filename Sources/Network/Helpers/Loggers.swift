//
//  Loggers.swift
//
//
//  Created by Amin on 25/04/2024.
//

import Foundation
import OSLog

extension Logger {
    static let network = Logger(
        subsystem: Bundle.main.bundleIdentifier ?? "MyApp",
        category: "Networking"
    )
}

// MARK: - RequestLogger
extension URLRequest {
    func log() {
        Logger.network.debug(
            """
            🤝 Request:\nURL: \(self.url?.absoluteString ?? "No URL")
            Method: \(self.httpMethod ?? "No HTTP Method")
            """
        )

        if let headers = self.allHTTPHeaderFields {
            if !headers.isEmpty {
                Logger.network.debug("Headers:")
            }
            for (key, value) in headers {
                Logger.network.debug("\t\(key): \(value)")
            }
        }
        if let bodyData = self.httpBody, let bodyString = String(data: bodyData, encoding: .utf8) {
            Logger.network.debug("Body: \(bodyString)")
        }
    }
}

// MARK: - ResponseLogger
extension Response {
    func log() {
        if let httpResponse = self.response as? HTTPURLResponse {
            Logger.network.debug(
                """
                ✅ Response:\nStatus Code: \(httpResponse.statusCode)
                URL: \(httpResponse.url?.absoluteString ?? "")
                """
            )

            do {
                let object = try JSONSerialization.jsonObject(with: self.data,options: [])
                if let prettyPrintedData = try? JSONSerialization.data(withJSONObject: object, options: .prettyPrinted),
                   let jsonString = String(data: prettyPrintedData, encoding: .utf8) {
                    Logger.network.debug("Serialized Object: \(jsonString)")
                } else {
                    Logger.network.error("Failed to pretty print JSON")
                }
            } catch {
                let nsError = error as NSError
                let debugDescription = String(describing: nsError.userInfo["NSDebugDescription"] ?? "")
                
                Logger.network.error(
                    """
                    ❌ Serialization Error: \(error.localizedDescription)
                    \(debugDescription)
                    """
                )
            }
        }
    }
}
