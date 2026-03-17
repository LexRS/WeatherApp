//
//  DayCell.swift
//  WeatherApp_Test_Power
//
//  Created by Алексей Поддубный on 11.03.2026.
//

import UIKit
import SnapKit

final class DayCell: UITableViewCell {
    
    static let reuseId = "DayCell"

    private let dayLabel = UILabel()
    private let iconView = UIImageView()
    private let tempLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    func configure(with model: WeatherModel.Day) {
        dayLabel.text = model.date
        tempLabel.text = "\(model.minTemp) / \(model.maxTemp)"
        iconView.image = model.image
    }
    
    func updateTextColor(_ color: UIColor) {
        dayLabel.textColor = color
        tempLabel.textColor = color
    }
}

private extension DayCell {
    func setup() {
        backgroundColor = .clear
        
        let stack = UIStackView(arrangedSubviews: [
            dayLabel,
            iconView,
            UIView(),
            tempLabel
        ])

        stack.axis = .horizontal
        stack.spacing = 12
        stack.alignment = .center

        contentView.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-12)
        }
        iconView.snp.makeConstraints { make in
            make.size.equalTo(30)
        }
    }
}
