//
//  ViewController.swift
//  codepath.week.two
//
//  Created by Michael on 12/07/2021.
//

import UIKit
import RappleProgressHUD

class BusinessesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    
    
    @IBOutlet weak var bussinsessSearchBar: UISearchBar!
    @IBOutlet weak var bussinsessTableView: UITableView!
    
    var businesss : [Business] = [] {
        didSet {
            if businesss.count != oldValue.count {
                bussinsessTableView.isHidden = businesss.count == 0
            }
        }
    }
    var term: String = ""
    var total: Int = 0
    var isLoading = false {
        didSet {
            if(isLoading) {
                RappleActivityIndicatorView.startAnimating()
            } else {
                RappleActivityIndicatorView.stopAnimation()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bussinsessSearchBar.delegate = self
        bussinsessTableView.dataSource = self
        bussinsessTableView.delegate = self
        bussinsessTableView.isHidden = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let q = bussinsessSearchBar.text {
            if !q.isEmpty {
                if q != term {
                    businesss.removeAll()
                }
                term = q
                getBussinesses(term: term, offset: 0)
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == "" {
            businesss.removeAll()
            bussinsessTableView.reloadData()
        }
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        businesss.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessTableViewCell") as! BusinessTableViewCell
        let row = indexPath.row
        cell.businessNameLabel.text = businesss[row].name
        cell.bussinessRatingBar.rating = businesss[row].rating ?? 0.0
        print("rating\(businesss[row].rating)")
        cell.businessImageView.loadImage(at: businesss[row].image_url ?? "")
        cell.businessAddressLabel.text = businesss[row].location?.address1 ?? ""
        var categories = ""
        for cat in businesss[row].categories! {
            if let name = cat.alias {
                if cat == businesss[row].categories?.last {
                    categories.append("\(name)")
                } else {
                    categories.append("\(name), ")
                }
            }

        }
        cell.businessCategoriesLabel.text = categories
        cell.businessReviewCountLabel.text = "\(businesss[row].review_count ?? 0) Reviews"
        
        if indexPath.row == businesss.count - 1 && businesss.count < total && !isLoading {
            let page = (businesss.count % 19) + 1
            getBussinesses(term: term, offset: (page * 20) + 1)
        }
        return cell
    }
    
    
    
}

extension BusinessesViewController {
    
    
    func getBussinesses(term: String,offset: Int) {
        guard !isLoading else {
            return
        }
        isLoading = true
        print("offset \(offset)")
        print("total \(total)")
        
        NetworkOperations().searchBusineses(term: term, offset: offset, completionsHandler: {(response) in
            if let businesses = response.businesses {
                self.isLoading = false
                self.total = response.total ?? 0
                if !businesses.isEmpty {
                    self.businesss.append(contentsOf: businesses)
                    self.bussinsessTableView.reloadData()
                }
            }
            
        })
    }
}

