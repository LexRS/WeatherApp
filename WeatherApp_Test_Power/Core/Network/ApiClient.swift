//
//  ApiClient.swift
//  WeatherApp_Test_Power
//
//  Created by Алексей Поддубный on 11.03.2026.
//

import Foundation

final class APIClient {
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        #if DEBUG
            let urlRequest = URLRequest(url: endpoint.url)
            print(urlRequest.cURL(pretty: true))
        #endif
        let (data, response) = try await URLSession.shared.data(from: endpoint.url)

        guard let http = response as? HTTPURLResponse,
              http.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode(T.self, from: data)
    }
}
