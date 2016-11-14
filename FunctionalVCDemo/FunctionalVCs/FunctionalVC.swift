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

extension Collection
  where
  Self.Iterator.Element: FunctionalVC,
  Self.Iterator.Element: UIViewController,
  Self.Iterator.Element.ResultType == Void
{
  func chain(on navVC: UINavigationController) -> Observable<Void> {
    return self.reduce(Observable<Void>.just(), { (acc, fvc) -> Observable<Void> in
      acc.flatMap({ _ -> Observable<Void> in
        print("About to push \(fvc) on stack \(navVC.viewControllers)")
        navVC.pushViewController(fvc, animated: true)
        return fvc.nextObservable
      })
    }).take(1)
  }
}
