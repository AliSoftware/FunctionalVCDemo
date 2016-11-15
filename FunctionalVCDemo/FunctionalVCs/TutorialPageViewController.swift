//
//  TutorialPageViewController.swift
//  FunctionalVCDemo
//
//  Created by Olivier Halligon on 15/11/2016.
//  Copyright © 2016 AliSoftware. All rights reserved.
//

import UIKit
import RxSwift

class TutorialPageViewController: UIViewController, Nextable {

  private let text: String
  private let color: UIColor
  private let nextButton = UIBarButtonItem(title: "Next", style: .done, target: nil, action: nil)
  @IBOutlet private weak var textLabel: UILabel!

  init(title: String, text: String, color: UIColor = .white) {
    self.text = text
    self.color = color
    super.init(nibName: String(describing: TutorialPageViewController.self), bundle: nil)
    self.title = title
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  var nextObservable: Observable<Void> {
    return nextButton.rx.tap
      .debounce(0.5, scheduler: MainScheduler.instance)
      .asObservable()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = self.color
    self.textLabel.text = self.text
    self.navigationItem.rightBarButtonItem = nextButton
  }
}

extension TutorialPageViewController {
  override var description: String {
    return "<TutorialPage \(self.title)>"
  }
}
