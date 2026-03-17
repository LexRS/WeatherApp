//
//  ErrorView.swift
//  WeatherApp_Test_Power
//
//  Created by Алексей Поддубный on 11.03.2026.
//

import UIKit
import SnapKit

final class ErrorView: UIView {
    private let label = UILabel()
    private let button = UIButton(type: .system)

    var onRetry: (() -> Void)?

    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) { fatalError() }

    func configure(message: String) {
        label.text = message
    }
}

private extension ErrorView {
    func setup() {
        label.textAlignment = .center
        label.numberOfLines = 0

        button.setTitle("Retry", for: .normal)
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)

        let stack = UIStackView(arrangedSubviews: [label, button])
        stack.axis = .vertical
        stack.spacing = 12
        stack.alignment = .center

        addSubview(stack)
        stack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    @objc func tap() {
        onRetry?()
    }
}
