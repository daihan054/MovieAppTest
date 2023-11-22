//
//  Observable.swift
//  MovieAppTest
//
//

import Foundation

class Observable<ObservableType> {
    var value: ObservableType? {
        didSet {
            listener?(value)
        }
    }
    
    private var listener: ((ObservableType?) -> Void)?
    
    init(_ value: ObservableType?) {
        self.value = value
    }
    
    func bind(_ listener: @escaping (ObservableType?) -> Void) {
        listener(value)
        self.listener = listener
    }
}
