//
//  ReusableCollectionViewCell.swift
//  Timeline
//
//  Created by user on 2021/12/03.
//

import Foundation
import UIKit

protocol ReusableCollectionViewCell: UICollectionViewCell {
    static var reuseIdentifier: String { get }
}

extension ReusableCollectionViewCell {
    public static var reuseIdentifier: String {
        let thisType = type(of: self)
        return String(describing: thisType)
    }
}
