//
//  DetailViewController.swift
//  SearchBook
//
//  Created by 윤새결 on 2020/12/31.
//

import UIKit

class DetailViewController: UIViewController {
  
  private let viewModel: DetailViewModelType
  
  private let scrollView: UIScrollView =  {
    let scrollView = UIScrollView()
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    return scrollView
  }()
  
  private let containerStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.spacing = 10
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
  
  private let publisherLabel: UILabel = {
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

    return button
  }()
  
  private let noteTextView: UITextView = {
    let textView = UITextView()
    textView.isEditable = true
    textView.font = UIFont.systemFont(ofSize: 12)
    textView.layer.cornerRadius = 8
    textView.layer.borderWidth = 1
    textView.layer.borderColor = UIColor.systemGray6.cgColor
    textView.backgroundColor = UIColor.systemGray5
    return textView
  }()
  
  //MARK:- Initalizing
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
    self.title = "Detail Book"
    self.view.addSubview(self.scrollView)
    self.scrollView.addSubview(self.containerStackView)
    
    let views = [self.imageView,
                 self.titleLabel,
                 self.subtitleLabel,
                 self.publisherLabel,
                 self.authorLabel,
                 self.isbn10Label,
                 self.isbn13Label,
                 self.totalPageLabel,
                 self.yearLabel,
                 self.priceLabel,
                 self.descriptionLabel,
                 self.linkButton,
                 self.noteTextView]
    for view in views {
      self.containerStackView.addArrangedSubview(view)
    }
  }
  
  //MARK:- Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //scrollView constraint setting
    let scrollViewConstraints = [self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
                                 self.scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
                                 self.scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
                                 self.scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
                                 self.scrollView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor)]
    NSLayoutConstraint.activate(scrollViewConstraints)
    
    //containerStackView constraint setting
    let containerStackViewConstraints = [self.containerStackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor,
                                                                                      constant: 5),
                                         self.containerStackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor,
                                                                                          constant: 5),
                                         self.containerStackView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor,
                                                                                           constant: -5),
                                         self.containerStackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor,
                                                                                         constant: -5),
                                         self.containerStackView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor)]
    NSLayoutConstraint.activate(containerStackViewConstraints)
    
    //noteTextView setting
    let noteTextViewConstraint = self.noteTextView.heightAnchor.constraint(equalToConstant: 100)
    self.noteTextView.delegate = self
    NSLayoutConstraint.activate([noteTextViewConstraint])
    
    //imageView constraint setting
    let imageViewHeightConstraint = self.imageView.heightAnchor.constraint(equalToConstant: 400)
    imageViewHeightConstraint.priority = UILayoutPriority(rawValue: 999)
    NSLayoutConstraint.activate([imageViewHeightConstraint])
    
    //UI data binding
    self.setupLayout(viewModel: self.viewModel)
    
    //keyboard handling noti
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(keyboardWillShowOrHide(notification:)),
                                           name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(keyboardWillShowOrHide(notification:)),
                                           name: UIResponder.keyboardWillHideNotification, object: nil)
    
    self.initializeHideKeyboard()
    self.setupLinkButton()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  private func setupLinkButton() {
    let attributeString = NSMutableAttributedString(string: "Link")
    attributeString.addAttribute(NSAttributedString.Key.underlineStyle,
                                 value: NSUnderlineStyle.single,
                                 range: NSRange(location: 0, length: attributeString.length))
    attributeString.addAttribute(NSAttributedString.Key.underlineColor,
                                 value: UIColor.systemBlue,
                                 range: NSRange(location: 0, length: attributeString.length))
    attributeString.addAttribute(NSAttributedString.Key.foregroundColor,
                                 value: UIColor.systemBlue,
                                 range: NSRange(location: 0, length: attributeString.length))
    self.linkButton.setAttributedTitle(attributeString, for: .normal)
    self.linkButton.addTarget(self, action: #selector(linkButtonAction), for: .touchDown)
  }
  
  @objc private func linkButtonAction() {
    self.viewModel.linkAction()
  }
  
  func setupLayout(viewModel: DetailViewModelType) {
    let detailBook = viewModel.detailBook
    self.imageView.setImage(with: detailBook.image.asEncodedURL())
    self.authorLabel.text = detailBook.authors
    self.descriptionLabel.text = detailBook.desc
    self.isbn10Label.text = "isbn10: \(detailBook.isbn10)"
    self.isbn13Label.text = "isbn13: \(detailBook.isbn13)"
    self.noteTextView.text = viewModel.note
    self.priceLabel.text = detailBook.price
    self.publisherLabel.text = detailBook.publisher
    self.ratingLabel.text = detailBook.rating
    self.subtitleLabel.text = detailBook.subtitle
    self.titleLabel.text = detailBook.title
    self.totalPageLabel.text = "Total Pages: \(detailBook.pages)"
    self.yearLabel.text = "Year: \(detailBook.year)"
  }
  
  private func initializeHideKeyboard() {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(
      target: self,
      action: #selector(dismissMyKeyboard))
    self.view.addGestureRecognizer(tap)
  }
  
  @objc private func dismissMyKeyboard() {
    self.view.endEditing(true)
  }
  
  @objc func keyboardWillShowOrHide(notification: NSNotification) {
    if let userInfo = notification.userInfo,
       let endValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
       let durationValue = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
      
      let endRect = self.view.convert(endValue, from: view.window)
      
      let bottomSafeAreaHeight: CGFloat = 30
      let keyboardOverlap = self.scrollView.frame.maxY - (endRect.origin.y - bottomSafeAreaHeight)
      
      self.scrollView.contentInset.bottom = keyboardOverlap
      self.scrollView.verticalScrollIndicatorInsets.bottom = keyboardOverlap
      
      let scrollPoint = self.scrollView.contentOffset.y + keyboardOverlap
      UIView.animate(withDuration: durationValue, delay: 0, animations: { [weak self] in
        guard let self = self else { return }
        self.view.layoutIfNeeded()
      }, completion: { [weak self] _ in
        guard let self = self else { return }
        self.scrollView.setContentOffset(CGPoint(x: 0, y: scrollPoint), animated: true)
      })
    }
  }
}

extension DetailViewController: UITextViewDelegate {
  func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
    if let text = textView.text,
       !text.isEmpty {
      self.viewModel.saveNote(with: text)
    }
    return true
  }
}
