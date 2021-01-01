//
//  DetailViewController.swift
//  SearchBook
//
//  Created by 윤새결 on 2020/12/31.
//

import UIKit

class DetailViewController: UIViewController {
  
  private let viewModel: DetailViewModelType
  
  private let scrollView: UIScrollView = UIScrollView()
  private let containerStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  
  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleToFill
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.font = UIFont.boldSystemFont(ofSize: 18)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let subtitleLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.font = UIFont.boldSystemFont(ofSize: 16)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let descriptionLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.font = UIFont.systemFont(ofSize: 16)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let authorLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 1
    label.font = UIFont.systemFont(ofSize: 16)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let priceLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 13)
    label.textColor = .systemRed
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let isbn10Label: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 12)
    label.textColor = .systemGray
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let isbn13Label: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 12)
    label.textColor = .systemGray
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let totalPageLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 12)
    label.textColor = .systemGray
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let yearLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 12)
    label.textColor = .systemGray
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let ratingLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 12)
    label.textColor = .orange
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let linkButton: UIButton = {
    let button = UIButton()
    let attributeString = NSMutableAttributedString(string: "Link")
    let attrubutes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single,
                                                      NSAttributedString.Key.underlineColor: UIColor.systemBlue,
                                                      NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]
    attributeString.addAttributes(attrubutes, range: NSRange(location: 0, length: attributeString.length))
    button.setAttributedTitle(attributeString, for: .normal)
    return button
  }()
  
  private let noteTextView: UITextView = {
    let textView = UITextView()
    textView.isEditable = true
    textView.font = UIFont.systemFont(ofSize: 12)
    return textView
  }()
  
  //MARK: -initalizing
  init(viewModel: DetailViewModelType) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
    self.view.backgroundColor = .systemBackground
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    super.loadView()
    
  }
  
  //MARK:- Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //textView setting
    self.noteTextView.delegate = self
  }
  
  
}

extension DetailViewController: UITextViewDelegate {
  
}
