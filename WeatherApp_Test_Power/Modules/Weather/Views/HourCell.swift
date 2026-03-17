//
//  HourCell.swift
//  WeatherApp_Test_Power
//
//  Created by Алексей Поддубный on 11.03.2026.
//

import UIKit
import SnapKit

final class HourCell: UICollectionViewCell {

    static let reuseId = "HourCell"

    private let timeLabel = UILabel()
    private let iconView = UIImageView()
    private let tempLabel = UILabel()

    private let stack = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) { fatalError() }

    func configure(with model: WeatherModel.Hour) {
        timeLabel.text = model.time
        tempLabel.text = model.temperature
        iconView.image = model.image
    }
    
    func updateTextColor(_ color: UIColor) {
        timeLabel.textColor = color
        tempLabel.textColor = color
    }
}

private extension HourCell {
    func setup() {
        timeLabel.font = .systemFont(ofSize: 14)
        timeLabel.textAlignment = .center
        

        tempLabel.font = .systemFont(ofSize: 16, weight: .medium)
        tempLabel.textAlignment = .center

        iconView.contentMode = .scaleAspectFit

        stack.axis = .vertical
        stack.spacing = 6
        stack.alignment = .center

        [timeLabel, iconView, tempLabel].forEach {
            stack.addArrangedSubview($0)
        }

        contentView.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        iconView.snp.makeConstraints { make in
            make.width.height.equalTo(28)
        }
    }
}
