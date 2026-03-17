//
//  UITableView+Ext.swift
//  WeatherApp_Test_Power
//
//  Created by Алексей Поддубный on 15.03.2026.
//

import UIKit

class DynamicHeightTableView: UITableView {
    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}
