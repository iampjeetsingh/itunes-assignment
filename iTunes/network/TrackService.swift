//
//  TrackService.swift
//  iTunes
//
//  Created by Paramjeet on 26/04/23.
//

import Foundation

class TrackService {
    let urlStr = "https://itunes.apple.com/search?term=adele"

    func fetchTracks(completion : @escaping (TrackResponse?, String?) -> ()){
        let url = URL(string: urlStr)
        if let content = readFromFile() {
            if let data = content.data(using: .utf8) {
                if let trackResponse = decodeJSON(data: data) {
                    completion(trackResponse, nil)
                } else {
                    completion(nil, "Failed to decode JSON")
                }
                return
            }
        }
        completion(nil, "Something went wrong")
        
//        if let safeUrl = url {
//            let session = URLSession(configuration: .default)
//            let task = session.dataTask(with: safeUrl) { (data, urlResponse, error) in
//                if error != nil {
//                    print(error?.localizedDescription)
//                    completion(nil, error?.localizedDescription)
//                }else if let safeData = data {
//                    if let trackResponse = self.decodeJSON(data: safeData) {
//                        print("Data Fetched! "+trackResponse.results[0].wrapperType)
//                        completion(trackResponse, nil)
//                    } else {
//                        completion(nil, "Failed to decode JSON")
//                    }
//                }else {
//                    completion(nil, "Something went wrong")
//                }
//            }
//            task.resume()
//        }
    }
    
    func readFromFile() -> String? {
        if let path = Bundle.main.path(forResource: "1", ofType: "txt") {
            do {
              let text = try String(contentsOfFile: path, encoding: .utf8)
              return text
            } catch {
              return nil
            }
        } else {
            return nil
        }
    }

    func decodeJSON(data: Data) -> TrackResponse? {
        let jsonDecoder = JSONDecoder()
        do {
            let trackResponse = try jsonDecoder.decode(TrackResponse.self, from: data)
            return trackResponse
        } catch {
            return nil
        }
    }
    
}
