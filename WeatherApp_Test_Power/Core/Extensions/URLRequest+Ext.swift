//
//  URLRequest+Ext.swift
//  WeatherApp_Test_Power
//
//  Created by Алексей Поддубный on 12.03.2026.
//

import Foundation

extension URLRequest {
    /// Generates a cURL command string for the URLRequest.
    func cURL(pretty: Bool = false) -> String {
        let newLine = pretty ? "\\\n" : ""
        let method = (self.httpMethod ?? "GET").uppercased()
        let url: String = (self.url?.absoluteString ?? "")
        var baseCommand = #"curl "\#(url)""#
        
        if method != "GET" {
            baseCommand += " -X \(method)"
        }
        
        var curlCommand = [baseCommand]
        
        // Add headers
        for (key, value) in self.allHTTPHeaderFields ?? [:] {
            curlCommand.append(#"-H "\#(key): \#(value)""#)
        }
        
        // Add HTTP body
        if let httpBody = self.httpBody, let bodyString = String(data: httpBody, encoding: .utf8) {
            // Escape special characters in the body string for shell safety
            let escapedBody = bodyString.replacingOccurrences(of: "\"", with: "\\\"")
            curlCommand.append(#"-d "\#(escapedBody)""#)
        }
        
        return curlCommand.joined(separator: " \(newLine)")
    }
}
