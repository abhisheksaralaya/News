//
//  APIClient.swift
//  News
//
//  Created by Apple on 27/01/21.
//

import Foundation
import CoreData
import UIKit

class APIClient: NSObject {
    func fetchRepoList(apiName: String, paramaters: String, completion: @escaping (Any?) -> Void) {
        var urlStr = ""
        switch apiName {
        case "getNews":
            urlStr = "https://hn.algolia.com/api/v1/search?\(paramaters)"
            
            
        default:
            break
        }

        let request = NSMutableURLRequest(url: NSURL(string: urlStr)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { [] (data, response, error) -> Void in
            if (error != nil) {
                print(error ?? "")
            } else {
                do {
                    switch apiName {
                    case "getNews":
                        let jsonData = try JSONDecoder().decode(NewsHits.self, from: data!)
                        completion(jsonData)
                        break
                    default:
                        break
                    }
                } catch let error {
                    print(error)
                }
            }
        })

        dataTask.resume()
    }
        
}
