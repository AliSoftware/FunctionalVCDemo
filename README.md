# FunctionalVCDemo

This project is a sample app demonstrating the concept of Functional ViewControllers using `RxSwift`.

## Concept

A Functional ViewController is a ViewController that can be used as a function `func show(input: T) -> Observable<U>`. It will display the ViewController to gather data from the user, wait for the user to validate, then emit a `.next` even on the returned `Observable<U>` once validated.

## Advantages

This pattern is useful to integrate a ViewContoller is a functional workflow, abstracting away the fact that the ViewController is a UI component and instead treating it as an asynchronous function getting inputs and asynchronously returning an output.

## Concept example

Imagine you have some Functional VCs that can be exposed in those functions:

* `func pickImage() -> Observable<UIImage>`
* `func askTitle() -> Observable<String>`
* `func askNote() -> Observable<Int>`

Each function presents a UIViewController, waits for the user to interact and validate (e.g. `pickImage` will present an `UIImagePickerController` and wait for the user to select an image), and asynchronously return the result (in case of `pickImage`, that's the `UIImage` obvously).

With this you can easily chain those functional VCs usng classic RxSwift reactive chains:

```swift
struct ImageDescription {
  let image: UIImage?
  let name: String?
  let note: Int?
}

var imageDesc: ImageDescription()
self.pickImage()
  .flatMap({ image in
    imageDesc.image = image
    self.askTitle()
  })
  .flatMap({ title in
    imageDesc.title = title
    self.askNote()
  })
  .subscribe(onNext: { note in
    imageDesc.note = note
    print(imageDesc)
  })
  .addDisposableTo(disposeBag)
```

This allows to read the workflow like a chain of steps happening one after the other, hiding away the complexity of asynchronicity.
