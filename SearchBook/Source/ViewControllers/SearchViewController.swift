//
//  SearchViewController.swift
//  SearchBook
//
//  Created by 윤새결 on 2020/12/28.
//

import UIKit

class SearchViewController: UIViewController {
  
  private let viewModel: SearchViewModelType
  private var lastQuery: String = ""
  private var recentQueries: [String] = UserDefaults.standard.array(forKey: "recentQuery") as? [String] ?? []
  
  private var isSearchBarTextEmpty: Bool {
    return self.searchController.searchBar.text?.isEmpty ?? true
  }
  private var isSearching: Bool {
    return self.searchController.isActive && !self.isSearchBarTextEmpty && self.viewModel.simpleBooks.isEmpty
  }
  private var isSearchEnd: Bool {
    return !self.isSearching && !self.viewModel.simpleBooks.isEmpty
  }
  
  private let tableView: UITableView = UITableView()
  private let searchController = UISearchController(searchResultsController: nil)
  
  //MARK: -initalizing
  init(viewModel: SearchViewModelType) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    super.loadView()
    
    self.title = "Search"
    
    //tableView setting
    self.tableView.delegate = self
    self.tableView.dataSource = self
    self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "keywordCell")
    self.tableView.register(SimpleBookTableViewCell.self, forCellReuseIdentifier: "bookCell")
    self.tableView.rowHeight = UITableView.automaticDimension
    self.view.addSubview(self.tableView)
    
    //searchController setting
    self.searchController.hidesNavigationBarDuringPresentation = true
    self.searchController.obscuresBackgroundDuringPresentation = false
    self.searchController.searchBar.delegate = self
    self.searchController.searchBar.placeholder = "Search Books"
    self.navigationItem.hidesSearchBarWhenScrolling = false
    self.navigationItem.searchController = self.searchController
  }
  
  //MARK:- Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
  
    //tableView autolayout
    self.tableView.translatesAutoresizingMaskIntoConstraints = false
    let tableViewConstraint = [
      self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
      self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
      self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
      self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
    ]
    NSLayoutConstraint.activate(tableViewConstraint)
  }
  
  //MARK:- api call methods
  private func searchBooks(with query: String) {
    self.viewModel.search(with: query) { [weak self] in
      guard let self = self else { return }
      self.tableView.reloadData()
    } failHandler: { [weak self] message in
      guard let self = self else { return }
      self.presentAlert(with: message)
    }
  }
  
  private func loadDetailBook(with index: Int) {
    self.viewModel.moveToDetail(with: index) { [weak self] viewModel in
      guard let self = self else { return }
      let detailViewController = DetailViewController(viewModel: viewModel)
      self.navigationController?.pushViewController(detailViewController, animated: true)
    } failHandler: { [weak self] message in
      guard let self = self else { return }
      self.presentAlert(with: message)
    }
  }
  
  ///notice alert method
  private func presentAlert(with message: String) {
    let alert = UIAlertController(title: "Notice",
                                  message: message,
                                  preferredStyle: .alert)
    let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    alert.addAction(alertAction)
    self.present(alert, animated: true, completion: nil)
  }
}

extension SearchViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if self.isSearchBarTextEmpty || self.isSearching {
      let query = self.recentQueries[indexPath.row]
      self.searchController.searchBar.text = query
      self.searchController.isActive = true
      self.searchBarSearchButtonClicked(self.searchController.searchBar)
      self.searchController.searchBar.resignFirstResponder()
      
      return
    }
    self.loadDetailBook(with: indexPath.row)
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    let booksCount = self.viewModel.simpleBooks.count
    if booksCount != 0, indexPath.row >= booksCount - 7 {
      guard let query = self.searchController.searchBar.text else { return }
      self.searchBooks(with: query)
    }
  }
}

extension SearchViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if self.isSearchBarTextEmpty {
      return self.recentQueries.count
    }
    return self.viewModel.simpleBooks.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let keywordCell = tableView.dequeueReusableCell(withIdentifier: "keywordCell") else {
      return UITableViewCell()
    }
    guard let bookCell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath) as? SimpleBookTableViewCell else {
      return UITableViewCell()
    }
    
    if self.isSearchBarTextEmpty {
      let recentQuery = self.recentQueries[indexPath.row]
      keywordCell.textLabel?.text = recentQuery
      return keywordCell
    }
    
    if self.isSearchEnd {
      let book = self.viewModel.simpleBooks[indexPath.row]
      bookCell.configureCell(with: book)
      return bookCell
    }
    
    return keywordCell
  }
}

extension SearchViewController: UISearchBarDelegate {
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    DispatchQueue.main.async { [weak self] in
      guard let self = self else {
        return
      }
      self.tableView.reloadData()
    }
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    guard let query = searchBar.text else { return }
    self.lastQuery = query
    self.viewModel.reset { [weak self] in
      guard let self = self else { return }
      self.tableView.reloadData()
    }
    if !self.recentQueries.contains(query) {
      self.recentQueries.append(query)
      UserDefaults.standard.set(self.recentQueries, forKey: "recentQuery")
    }
    self.searchBooks(with: query)
  }
}
