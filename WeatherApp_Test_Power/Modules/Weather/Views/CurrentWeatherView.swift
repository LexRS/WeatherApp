//
//  CurrentWeatherView.swift
//  WeatherApp_Test_Power
//
//  Created by Алексей Поддубный on 11.03.2026.
//

import UIKit
import SnapKit

final class CurrentWeatherView: UIView {
    private lazy var cityLabel = _cityLabel
    private lazy var tempLabel = _tempLabel
    private lazy var conditionLabel = _conditionLabel
    private lazy var iconView = _iconView
    private lazy var verticalStackView = _verticalStackView

    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) { fatalError() }

    func configure(with model: WeatherModel.Current) {
        cityLabel.text = model.city
        tempLabel.text = model.temperature
        conditionLabel.text = model.condition.displayName
        iconView.image = model.image
        updateTextColor(model.isDaytime)
    }
}

private extension CurrentWeatherView {
    func setup() {
        [cityLabel, tempLabel, iconView, conditionLabel].forEach {
            verticalStackView.addArrangedSubview($0)
        }

        addSubview(verticalStackView)
        verticalStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func updateTextColor(_ isDaytime: Bool) {
        let labels = [cityLabel, tempLabel, conditionLabel]
        labels.forEach { label in
            label.textColor = isDaytime ? .black : .white
        }
    }
}

private extension CurrentWeatherView {
    var _cityLabel: UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28, weight: .semibold)
        label.textColor = .white
        return label
    }
    
    var _tempLabel: UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 110, weight: .thin)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }
    
    var _conditionLabel: UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textColor = .white
        return label
    }
    
    var _iconView: UIImageView {
        let iconView = UIImageView()
        iconView.contentMode = .scaleAspectFit
        return iconView
    }
    
    var _verticalStackView: UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 4
        return stack
    }
}
