//
//  ViewController.swift
//  SwiftRxSwift
//
//  Created by 郎烨 on 2020/11/27.
//  Copyright © 2020 郎烨. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

enum KSJError: Error {
    case test
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        test()
    }
    
    func test() {
        
        let label = UILabel.init(frame: CGRect(x: 10,y: 10,width: 20,height: 20))
        self.view.addSubview(label)
        
        let bag = DisposeBag()
        
        let observable = Observable<Int>.create { observer in
            observer.onNext(11)
            observer.onNext(22)
            observer.onNext(33)
            observer.onError(KSJError.test)
            return Disposables.create()
        }
        
//        let observable = Observable.just(1)
        
//        let observable = Observable.from([1, 2, 3])
//        let observable = Observable<Int>.timer(.seconds(2), period: .seconds(1), scheduler: MainScheduler.instance)
//
//        let _ = observable.takeUntil(self.rx.deallocated).map { "\($0)"}.bind(to: label.rx.text)
        
        let disposeable = observable.subscribe { event in
            switch event {
            case .next(let element):
                print("next",element)
            case .error(let error):
                print("error",error)
            case .completed:
                print("completed")
            }
        }
//        disposeable.dispose()
        
//        observable.subscribe(onNext: { element in
//            print("next",element)
//        }, onError: { error in
//            print("error",error)
//        }, onCompleted: {
//            print("completed")
//        }).dispose()
        
        
//        observable.subscribe(onNext: { element in
//            print("next",element)
//        }, onError: { error in
//            print("error",error)
//        }, onCompleted: {
//            print("completed")
//        },onDisposed: {
//            print("onDisposed")
//        }).disposed(by: bag)
    }
}

