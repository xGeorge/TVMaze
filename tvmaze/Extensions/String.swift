//
//  String.swift
//  tvmaze
//
//  Created by Jorge Armando Torres Perez on 17/01/21.
//

import UIKit

extension String {
    func urlRepresentation() -> URL? {
        guard let url = URL(string: self) else {
            return nil
        }
        return url
    }
}
