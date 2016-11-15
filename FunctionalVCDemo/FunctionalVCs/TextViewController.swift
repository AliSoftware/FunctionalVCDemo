//
//  TextViewController.swift
//  FunctionalVCDemo
//
//  Created by Olivier Halligon on 14/11/2016.
//  Copyright © 2016 AliSoftware. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TextViewController: UIViewController, Nextable, UITextFieldDelegate {

  @IBOutlet private weak var textField: UITextField!

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    textField.becomeFirstResponder()
  }

  private let subject = PublishSubject<String>()
  public var nextObservable: Observable<String> {
    return subject.asObservable()
  }

  @IBAction private func validateAction(_ sender: Any) {
    subject.onNext(textField.text ?? "")
  }

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    subject.onNext(textField.text ?? "")
    return false
  }
}
