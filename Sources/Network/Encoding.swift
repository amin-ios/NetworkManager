//
//  ParameterEncoding.swift
//
//  Created by Amin on 17/10/2023.
//

import Foundation


public enum Encoding {
    /// URLEncoding refers to a process of encoding URL query parameters or path components in a format that is safe for transmission over HTTP
    case URLEncoding
    /// JSONEncoding is a process used to encode request parameters or data into JSON (JavaScript Object Notation) format, which is commonly used in RESTful APIs. When making HTTP requests, especially POST, PUT, or PATCH requests, parameters are often sent in the body of the request as JSON.
    case JSONEncoding
    /// MultipartEncoding (or multipart/form-data encoding) is a way to encode data for sending large files or complex data (like forms with files) over HTTP. It’s used when an HTTP request needs to send not only key-value pairs (such as form fields) but also files like images, videos, or documents. This encoding is specifically designed for file uploads because it allows binary data to be transmitted alongside textual data.
    /// - Note: Look at the parameters example below
    /// 
    /// Example:
    ///
    /// ```swift
    /// let params = [
    ///     // plain form field
    ///     "name": userName,
    ///     // file field
    ///     "avatar": MultipartFormData(
    ///         name: "avatar.jpg",
    ///         data: imageData,
    ///         mimeType: "image/jpeg"
    ///     )
    /// ]
    /// ```
    case MULTIPARTEncoding
}



extension NSMutableData {
    func appendString(_ string: String) {
        if let data = string.data(using: .utf8) {
            self.append(data)
        }
    }
}
