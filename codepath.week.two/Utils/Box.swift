//
//  Box.swift
//  codepath.week.two
//
//  Created by Michael on 13/07/2021.
//

import Foundation


final class Box<T> {
    typealias Listener = (T) -> Void
    var listener: Listener?
    
    var value : T {
        didSet {
            listener?(value)
        }
    }
    
    init(value: T) {
        self.value = value
    }
    
    func bind(listener: Listener?) {
        self.listener = listener
        
    }
    
    
}
