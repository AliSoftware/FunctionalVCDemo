//
//  ValueViewController.swift
//  FunctionalVCDemo
//
//  Created by Olivier Halligon on 14/11/2016.
//  Copyright © 2016 AliSoftware. All rights reserved.
//

import UIKit
import RxSwift


class ValueViewController: UIViewController, FunctionalVC {

  @IBOutlet private weak var stepper: UIStepper!
  @IBOutlet private weak var valueLabel: UILabel!

  private let disposeBag = DisposeBag()

  override func viewDidLoad() {
    super.viewDidLoad()
    stepper.rx.value.map({ "\($0)" })
      .bindTo(valueLabel.rx.text)
      .addDisposableTo(disposeBag)
  }

  private let subject = PublishSubject<Int>()
  var nextObservable: Observable<Int> {
    return subject.asObservable()
  }

  @IBAction func validateAction(_ sender: Any) {
    subject.onNext(Int(stepper.value))
  }
}
