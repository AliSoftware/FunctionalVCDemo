//
//  FunctionalVC.swift
//  FunctionalVCDemo
//
//  Created by Olivier Halligon on 14/11/2016.
//  Copyright © 2016 AliSoftware. All rights reserved.
//

import RxSwift

protocol FunctionalVC {
  associatedtype ResultType
  var nextObservable: Observable<ResultType> { get }

  func showModal(on presentingVC: UIViewController) -> Observable<Self.ResultType>
}

extension FunctionalVC where Self: UIViewController {
  func showModal(on presentingVC: UIViewController) -> Observable<Self.ResultType> {
    presentingVC.present(self, animated: true)
    return self.nextObservable.take(1)
      .do(onNext: { _ in
        presentingVC.dismiss(animated: true)
      })
  }
}
