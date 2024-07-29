//
//  File.swift
//
//
//  Created by Nitish Gadangi on 08/07/24.
//

import Foundation
import RxSwift
import RxCocoa

public extension ObservableType {
    func asDriverOrEmpty() -> Driver<Element> {
        return self.asDriver { err in
            return Driver.empty()
        }
    }
}
