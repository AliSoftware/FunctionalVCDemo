//
//  ViewController.swift
//  FunctionalVCDemo
//
//  Created by Olivier Halligon on 14/11/2016.
//  Copyright © 2016 AliSoftware. All rights reserved.
//

import UIKit
import RxSwift

class HomeViewController: UIViewController {

  private let disposeBag = DisposeBag()

  @IBAction func askForText(_ sender: UIButton) {
    let vc = TextViewController()
    vc.showModal(on: self)
      .subscribe(onNext: { text in
        self.showAlert(title: "Text returned", message: text)
      })
      .addDisposableTo(disposeBag)
  }

  @IBAction func askForNumber(_ sender: UIButton) {
    let vc = ValueViewController()
    vc.showModal(on: self)
      .subscribe(onNext: { (value: Int) in
        self.showAlert(title: "Value selected", message: "\(value)")
      })
      .addDisposableTo(disposeBag)
  }

  @IBAction func showFullForm(_ sender: UIButton) {
    let vc = FormViewController()
    vc.showModal(on: self)
      .subscribe(onNext: { formVM in
        let msg = "\(formVM.firstName) \(formVM.lastName), \(formVM.city)"
        self.showAlert(title: "Form result", message: msg)
      })
    .addDisposableTo(disposeBag)
  }

  @IBAction func startTutorial(_ sender: UIButton) {
    let nc = UINavigationController()
    let vcList = [
      TutorialPageViewController(title: "Page 1", text: "Welcome!"),
      TutorialPageViewController(title: "Page 2", text: "Please continue", color: .yellow),
      TutorialPageViewController(title: "Page 3", text: "Almost there", color: .cyan),
      TutorialPageViewController(title: "Page 4", text: "Congratulations, you're done!", color: .green)
    ]

    self.present(nc, animated: true)
    vcList.chain(on: nc)
      .subscribe(onCompleted: {
        self.dismiss(animated: true)
      })
      .addDisposableTo(disposeBag)
  }

  private func showAlert(title: String, message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default))
    self.present(alert, animated: true)
  }
}

