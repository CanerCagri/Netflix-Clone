//
//  String.swift
//  Netflix Clone
//
//  Created by Caner Çağrı on 18.12.2022.
//

import Foundation


extension String {
    func upperCasedFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
