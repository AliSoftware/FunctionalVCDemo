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

class TextViewController: UIViewController, FunctionalVC, UITextFieldDelegate {

  @IBOutlet private var textField: UITextField!

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    textField.becomeFirstResponder()
  }

  private let subject = PublishSubject<String>()
  @IBAction private func validateAction(_ sender: Any) {
    subject.on(.next(textField.text ?? ""))
  }

  public var nextObservable: Observable<String> {
    return subject.asObservable()
  }

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    subject.on(.next(textField.text ?? ""))
    return false
  }
}
