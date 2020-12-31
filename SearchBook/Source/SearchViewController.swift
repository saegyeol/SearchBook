//
//  SearchViewController.swift
//  SearchBook
//
//  Created by 윤새결 on 2020/12/28.
//

import UIKit

class SearchViewController: UIViewController {
  
  public var apiService: APIServiceType!
  private let tableView: UITableView = UITableView()
  private let searchController = UISearchController(searchResultsController: nil)
  
  override func loadView() {
    super.loadView()
    
    self.title = "Search"
    
    //tableView setting
    self.tableView.delegate = self
    self.tableView.dataSource = self
    self.view.addSubview(self.tableView)
    
    //searchController setting
    self.searchController.hidesNavigationBarDuringPresentation = true
    self.searchController.obscuresBackgroundDuringPresentation = false
    self.searchController.searchBar.delegate = self
    self.searchController.searchBar.placeholder = "Search Books"
    self.searchController.searchResultsUpdater = self
    self.navigationItem.hidesSearchBarWhenScrolling = false
    self.navigationItem.searchController = self.searchController
  }
  
  //MARK:- Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    self.tableView.translatesAutoresizingMaskIntoConstraints = false
    let tableViewConstraint = [
      self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
      self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
      self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
      self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
    ]
    NSLayoutConstraint.activate(tableViewConstraint)
  }
}

extension SearchViewController: UITableViewDelegate {
  
}

extension SearchViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return UITableViewCell()
  }
}

extension SearchViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {

  }
}

extension SearchViewController: UISearchBarDelegate {

}
