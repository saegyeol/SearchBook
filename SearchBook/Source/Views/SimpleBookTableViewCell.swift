//
//  SimpleBookTableViewCell.swift
//  SearchBook
//
//  Created by 윤새결 on 2021/01/01.
//

import UIKit

class SimpleBookTableViewCell: UITableViewCell {
  
  private let bookImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleToFill
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 1
    label.font = UIFont.systemFont(ofSize: 16)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let subtitleLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 1
    label.font = UIFont.systemFont(ofSize: 14)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let priceLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 12)
    label.textColor = .systemRed
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let isbnLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 12)
    label.textColor = .systemGray
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let urlLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 12)
    label.textColor = .systemGray
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let containerStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  
  private let contentStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.distribution = .fillEqually
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.selectionStyle = .none
    self.contentStackView.addArrangedSubview(self.titleLabel)
    self.contentStackView.addArrangedSubview(self.subtitleLabel)
    self.contentStackView.addArrangedSubview(self.isbnLabel)
    self.contentStackView.addArrangedSubview(self.priceLabel)
    self.contentStackView.addArrangedSubview(self.urlLabel)
    
    self.containerStackView.addArrangedSubview(self.bookImageView)
    self.containerStackView.addArrangedSubview(self.contentStackView)
    
    self.contentView.addSubview(self.containerStackView)
    
    //Layouts: imageView
    let iamgeViewWidth: CGFloat = 100
    let priority = UILayoutPriority(rawValue: 999)
    let widthConstraint = self.bookImageView.widthAnchor.constraint(equalToConstant: iamgeViewWidth)
    widthConstraint.priority = priority
    let imageViewConstraints = [
      widthConstraint,
      self.bookImageView.heightAnchor.constraint(equalTo: self.bookImageView.widthAnchor)
    ]
    NSLayoutConstraint.activate(imageViewConstraints)
    
    //Layouts: containerStackView
    let containerStackViewConstraints = [
      self.containerStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
      self.containerStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5),
      self.containerStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5),
      self.containerStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5)
    ]
    NSLayoutConstraint.activate(containerStackViewConstraints)
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public func configureCell(with book: SimpleBook) {
    self.bookImageView.setImage(with: book.image.asEncodedURL())
    self.titleLabel.text = book.title
    self.subtitleLabel.isHidden = book.subtitle.isEmpty
    self.subtitleLabel.text = book.subtitle
    self.isbnLabel.text = "isbn13: \(book.isbn13)"
    self.priceLabel.text = book.price
    self.urlLabel.text = book.url
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    self.bookImageView.image = nil
  }

}
