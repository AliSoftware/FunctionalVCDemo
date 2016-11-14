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

  @IBAction func startTutorial(_ sender: UIButton) {
    self.showAlert(title: "Not implemented", message: "Not implemented yet!")
  }

  private func showAlert(title: String, message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default))
    self.present(alert, animated: true)
  }
}

