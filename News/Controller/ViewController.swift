//
//  ViewController.swift
//  News
//
//  Created by Apple on 27/01/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    
    @IBOutlet var newsViewModel: NewsViewModel!
    
    var searchedText = ""

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tblNews: UITableView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchBar.delegate = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return newsViewModel.hitsCount()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsViewModel.newsCount(section: section)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == newsViewModel.newsCount(section: indexPath.section) - 1 && indexPath.section < newsViewModel.nbPages() {
            newsViewModel.getData(apiName: "getNews", paramaters: "query=\(searchedText)&page=\(indexPath.section + 2)", completion:  {
                self.tblNews.dataSource = self
                self.tblNews.delegate = self
                self.tblNews.reloadData()
            })
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! NewsTableViewCell
        cell.lblTitle.text = newsViewModel.newsTitle(section: indexPath.section, row: indexPath.row)
        cell.lblAuthor.text = newsViewModel.newsAuthor(section: indexPath.section, row: indexPath.row)
        cell.lblCreatedAt.text = newsViewModel.newsCreatedAt(section: indexPath.section, row: indexPath.row)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let webViewController = WebViewController()
        webViewController.urlString = newsViewModel.newsUrl(section: indexPath.section, row: indexPath.row)
        self.navigationController?.pushViewController(webViewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedText = searchText
            self.newsViewModel.removeNewsHitsData()
        newsViewModel.getData(apiName: "getNews", paramaters: "query=\(searchText)&page=1", completion:  {
            self.tblNews.dataSource = self
            self.tblNews.delegate = self
            self.tblNews.reloadData()
        })
    }
    
    
    
}




class NewsTableViewCell: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAuthor: UILabel!
    @IBOutlet weak var lblCreatedAt: UILabel!
    
    override func awakeFromNib() {
        layoutIfNeeded()
    }
}

