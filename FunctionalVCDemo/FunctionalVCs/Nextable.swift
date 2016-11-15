//
//  Nextable.swift
//  FunctionalVCDemo
//
//  Created by Olivier Halligon on 14/11/2016.
//  Copyright © 2016 AliSoftware. All rights reserved.
//

import RxSwift

protocol Nextable {
  associatedtype ResultType
  var nextObservable: Observable<ResultType> { get }
}

extension Nextable where Self: UIViewController {
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
  Self.Iterator.Element: Nextable,
  Self.Iterator.Element: UIViewController,
  Self.Iterator.Element.ResultType == Void
{
  /// Build a chain just().flatMap(fvc1.nextObservable).flatMap(fvc2.nextObservable)….flatMap(fvcN.nextObservable).take(1)
  /// from an array of Nextables, pushing the fvcX on the NavigationController on each step.
  ///
  /// Returns an Observable<Void> emiting one `.next` + `.completed` once the use hits "Next" on the last screen.
  func chain(on navVC: UINavigationController) -> Observable<Void> {
    // Note: take(1) is there so that the `.next` emited by the last FVC at the end of the chain
    // is followed by a `.completed` event to signal the end of the chain.
    return self.reduce(Observable<Void>.just(), { (acc, fvc) -> Observable<Void> in
      acc.flatMap({ _ -> Observable<Void> in
        print("About to push \(fvc) on stack \(navVC.viewControllers)")
        navVC.pushViewController(fvc, animated: true)
        return fvc.nextObservable
      })
    }).take(1)
  }
}
