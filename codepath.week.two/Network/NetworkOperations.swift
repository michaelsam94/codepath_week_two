//
//  NetworkOperations.swift
//  codepath.week.two
//
//  Created by Michael on 12/07/2021.
//

import Foundation
import Alamofire

let posterBaseUrl = "https://image.tmdb.org/t/p/w154"

class NetworkOperations {
    
    private let baseUrl: String = "https://api.yelp.com/v3/"
    private let apiKey: String
    
    init() {
        apiKey = Utilities().getApiKey()
    }
    
    public func searchBusineses(term: String,offset: Int,sortBy: String = "",oponNow: Bool = false,completionsHandler: @escaping (BusinessesRes) -> Void) {
        let headers = [
            "Authorization" : apiKey
        ]
        var paramaters = [
            "limit": "20",
            "offset": String(offset),
            "location": "CA",
            "term": term
        ]
        if sortBy != "" {
            paramaters["sort_by"] = sortBy
        }
        if oponNow {
            paramaters["open_now"] = "true"
        }
        let request = AF.request("\(baseUrl)businesses/search", method: .get,parameters: paramaters,headers: HTTPHeaders(headers))

        request.responseDecodable(of: BusinessesRes.self,completionHandler:{ (response) in
            guard let bussineses = response.value else { return }
            debugPrint()
            completionsHandler(bussineses)
        })
    }
    
}
