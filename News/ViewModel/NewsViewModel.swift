//
//  NewsViewModel.swift
//  News
//
//  Created by Apple on 27/01/21.
//

import Foundation
import Network
import UIKit
import CoreData

class NewsViewModel: NSObject {
    @IBOutlet var apiClient: APIClient!
    
    var newsHits: [NewsHits]?
    
    func getData(apiName: String, paramaters: String, completion: @escaping () -> Void) {
        let monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [self] path in
            if path.status == .satisfied {
                self.apiClient.fetchRepoList(apiName: apiName, paramaters: paramaters, completion: { (data) in
                    DispatchQueue.main.async {
                        switch apiName {
                        case "getNews":
                            if self.newsHits == nil {
                                self.newsHits = [data as! NewsHits]
                            } else {
                                self.newsHits?.append((data as! NewsHits))
                            }
                            break
                        default:
                            break
                        }
                        monitor.cancel()
                        completion()
                    }
                })
            } else {
                //No Internet
                
            }
        }
    }
    
    func removeNewsHitsData () {
        self.newsHits?.removeAll()
    }
    
    func hitsCount() -> Int {
        return self.newsHits?.count ?? 0
    }
    
    func newsCount(section:Int) -> Int {
        return self.newsHits?[section].hits?.count ?? 0
    }
    
    func nbPages() -> Int {
        return self.newsHits?[0].nbPages ?? 0
    }
    
    func newsTitle(section: Int, row: Int) -> String {
        return self.newsHits?[section].hits?[row].title ?? "No Title"
    }
    
    func newsAuthor(section: Int, row: Int) -> String {
        return self.newsHits?[section].hits?[row].author ?? "- Anonymous"
    }
    
    func newsCreatedAt(section: Int, row: Int) -> String {
        return self.newsHits?[section].hits?[row].created_at ?? "No Date"
    }
    
    func newsUrl(section: Int, row: Int) -> String {
        return self.newsHits?[section].hits?[row].url ?? "No url"
    }
}
