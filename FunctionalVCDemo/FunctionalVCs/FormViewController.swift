//
//  FormViewController.swift
//  FunctionalVCDemo
//
//  Created by Olivier Halligon on 14/11/2016.
//  Copyright © 2016 AliSoftware. All rights reserved.
//

import UIKit
import RxSwift

class FormViewController: UIViewController, Nextable, UITextFieldDelegate {

  struct ViewModel {
    let firstName: String
    let lastName: String
    let city: String
  }

  @IBOutlet weak var firstNameLabel: UITextField!
  @IBOutlet weak var lastNameLabel: UITextField!
  @IBOutlet weak var cityLabel: UITextField!

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    firstNameLabel.becomeFirstResponder()
  }

  private let subject = PublishSubject<ViewModel>()
  var nextObservable: Observable<ViewModel> {
    return subject.asObservable()
  }

  @IBAction func validateAction(_ sender: Any) {
    let vm = ViewModel(
      firstName: firstNameLabel.text ?? "",
      lastName: lastNameLabel.text ?? "",
      city: cityLabel.text ?? ""
    )
    subject.onNext(vm)
  }

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    switch textField {
    case firstNameLabel: lastNameLabel.becomeFirstResponder()
    case lastNameLabel: cityLabel.becomeFirstResponder()
    case cityLabel: validateAction(self)
    default: break
    }

    return false
  }
}
