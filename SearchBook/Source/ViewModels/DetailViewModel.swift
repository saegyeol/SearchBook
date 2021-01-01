//
//  DetailViewModel.swift
//  SearchBook
//
//  Created by 윤새결 on 2021/01/01.
//

import Foundation

protocol DetailViewModelType {
  var detailBook: DetailBook { get }
  var note: String? { get }

  func saveNote(with content: String)
}

class DetailViewModel: DetailViewModelType {
  var detailBook: DetailBook
  var note: String?
  let noteKey: String = "note"
  
  init(detailBook: DetailBook) {
    self.detailBook = detailBook
    self.note = UserDefaults.standard.dictionary(forKey: self.noteKey)?[detailBook.isbn13] as? String
  }
  
  func saveNote(with content: String) {
    let isbn13 = self.detailBook.isbn13
    if var savedNote = UserDefaults.standard.dictionary(forKey: self.noteKey) {
      savedNote[isbn13] = content
      UserDefaults.standard.setValue(savedNote, forKey: self.noteKey)
    } else {
      let data = [isbn13 : content]
      UserDefaults.standard.setValue(data, forKey: self.noteKey)
    }
  }
}
