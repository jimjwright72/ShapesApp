//
//  CricutRestEndpointRepository.swift
//  ShapesApp
//
//  Created by Jimmy Wright on 7/28/25.
//

import Foundation

// Create protocol to define Cricut Rest APIs.  Currently only 1 API to get buttons
protocol CricutRestEndpointRepository {
    func getCricutShapeButtons() async -> [CricutButton]
}

// Create simple singleton implementation pattern for Cricut Rest API
final class CricutRestEndpointRepositoryImpl: CricutRestEndpointRepository {
    
    static let shared = CricutRestEndpointRepositoryImpl()
    // The url should be using https protocol otherwise you will get NSTransport security error when using http protocol
    //
    // Changing to https seemed to work but not knowing if this was part of the assessment I left it as "http" and added App Transport Security Settings, along with setting Allow Arbitrary Loads to true
    // to info.plist
    //
    // The returned JSON for buttons is considered invalid by JSON Beautifier due to the extra commas but JSONDecoder still was able to decode it.
    //
    private let cricutButtonEndpoint = "http://staticcontent.cricut.com/static/test/shapes_001.json"
    
    private init() {}
    
    func getCricutShapeButtons() async -> [CricutButton] {
        let urlStr = cricutButtonEndpoint
        guard let urlStrEncoded = urlStr.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else { return [] }
        guard let url =  URL(string: urlStrEncoded) else { return [] }
        let request = createRequestWith(url: url)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            // Check for http status error
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                if let httpResponse = response as? HTTPURLResponse { print("Cricut::getCricutShapeButtons, httpResponse.statusCode: \(httpResponse.statusCode)") }
                return []
            }
            
            // Debugging print response in string form to console
            //let jsonReply = String(data: data, encoding: .utf8)!
            //print("Cricut JSON Reply:\n\(jsonReply)")
            
            let cricutResponse = try JSONDecoder().decode(CricutButtonsResponse.self, from: data)
            return cricutResponse.buttons
        } catch (let error) {
            print(error)
        }
        return []
    }
    
    // Some Rest APIs are more complex than others where you have to set header fields for API key, and possibly set parameters in body of request
    // That is why I separated this into a separate function for future changes
    private func createRequestWith(url: URL) -> URLRequest {
        var request  = URLRequest.init(url: url)
        request.httpMethod = "GET"
        return request
    }
    
}
