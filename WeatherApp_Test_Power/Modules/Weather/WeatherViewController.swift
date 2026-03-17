//
//  WeatherViewController.swift
//  WeatherApp_Test_Power
//
//  Created by Алексей Поддубный on 11.03.2026.
//

import UIKit
import SnapKit

final class WeatherViewController: UIViewController {
    
    private lazy var activityIndicator = _activityIndicator
    private lazy var errorView = _errorView
    private lazy var scrollView = _scrollView
    private lazy var contentStack: UIStackView = _stackView
    private lazy var currentWeatherView = _currentWeatherView
    private lazy var hourlyWeatherCollectionView = _hourlyWeatherCollectionView
    private lazy var dailyWeatherTableView = _dailyTableView
    
    private let gradientLayer = CAGradientLayer()

    private var hourlyItems: [WeatherModel.Hour] = []
    private var dailyItems: [WeatherModel.Day] = []
    
    private var textColor: UIColor = .white
    
    private let presenter: WeatherPresenter

    init(presenter: WeatherPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addSubviews()
        setupConstraints()
        setActions()
        setupGradient()
        presenter.viewDidLoad()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = view.bounds
    }
    
    private func setupGradient() {
        gradientLayer.colors = [
            UIColor.systemBlue.cgColor,
            UIColor.systemTeal.cgColor
        ]

        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)

        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func updateGradient(for condition: WeatherCondition, isDaytime: Bool) {
        let colors = BackgroundDesign.getColors(for: condition, isDaytime: isDaytime)
        
        let animation = CABasicAnimation(keyPath: "colors")
        animation.fromValue = gradientLayer.colors
        animation.toValue = colors.map { $0.cgColor }
        animation.duration = 1.5
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        
        gradientLayer.add(animation, forKey: "colorChange")
        gradientLayer.colors = colors.map { $0.cgColor }
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
    }
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentStack)

        contentStack.addArrangedSubview(currentWeatherView)
        contentStack.addArrangedSubview(hourlyWeatherCollectionView)
        contentStack.addArrangedSubview(dailyWeatherTableView)

        view.addSubview(activityIndicator)
        view.addSubview(errorView)
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        contentStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView.snp.width)
        }
        hourlyWeatherCollectionView.snp.makeConstraints { make in
            make.height.equalTo(90)
        }
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        errorView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func setActions() {
        errorView.onRetry = { [weak self] in
            self?.presenter.retryTapped()
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension WeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        hourlyItems.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: HourCell.reuseId,
            for: indexPath
        ) as? HourCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: hourlyItems[indexPath.row])
        cell.updateTextColor(textColor)
        return cell
    }
}

// MARK: - UITableViewDataSource

extension WeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dailyItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DayCell.reuseId, for: indexPath) as? DayCell else {
            return UITableViewCell()
        }
        cell.configure(with: dailyItems[indexPath.row])
        cell.updateTextColor(self.textColor)
        return cell
    }
}

// MARK: - WeatherView

extension WeatherViewController: WeatherView {
    func render(_ state: WeatherViewState) {
        switch state {
        case .loading:
            showLoading()
        case .content(let model):
            showContent(model)
        case .error(let message):
            showError(message)
        }
    }
    
    private func showLoading() {
        activityIndicator.startAnimating()
        scrollView.isHidden = true
        errorView.isHidden = true
    }

    private func showContent(_ model: WeatherModel) {
        activityIndicator.stopAnimating()
        scrollView.isHidden = false
        errorView.isHidden = true

        apply(model)
    }

    private func showError(_ message: String) {
        activityIndicator.stopAnimating()
        scrollView.isHidden = true

        errorView.isHidden = false
        errorView.configure(message: message)
    }
}

private extension WeatherViewController {
    func apply(_ model: WeatherModel) {
        //Header view for current weather and location
        currentWeatherView.configure(with: model.current)
        
        //Background design update
        updateGradientColors(model.current.condition, isDaytime: model.current.isDaytime)
        
        //Tableview and collectionview update
        textColor = model.current.isDaytime ? .black : .white
        hourlyItems = model.hourly
        hourlyWeatherCollectionView.reloadData()
        dailyItems = model.days
        dailyWeatherTableView.reloadData()
    }
    
    func updateGradientColors(_ condition: WeatherCondition, isDaytime: Bool) {
        gradientLayer.removeAllAnimations()
        updateGradient(for: condition, isDaytime: isDaytime)
    }
}

// MARK: - Subviews

private extension WeatherViewController {
    var _scrollView: UIScrollView {
        let result = UIScrollView()
        return result
    }
    
    var _stackView: UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 24
        stack.distribution = .fill
        stack.alignment = .fill
        return stack
    }
    
    var _errorView: ErrorView {
        let result = ErrorView()
        return result
    }
    
    var _currentWeatherView: CurrentWeatherView {
        let result = CurrentWeatherView()
        return result
    }
    
    var _activityIndicator: UIActivityIndicatorView {
        let result = UIActivityIndicatorView(style: .large)
        return result
    }
    
    var _hourlyWeatherCollectionView: UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 60, height: 90)
        layout.minimumLineSpacing = 12

        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .clear
        collection.dataSource = self
        collection.delegate = self
        collection.register(
            HourCell.self,
            forCellWithReuseIdentifier: HourCell.reuseId
        )
        
        return collection
    }
    
    var _dailyTableView: UITableView {
        let table = DynamicHeightTableView()
        table.rowHeight = 60
        table.separatorStyle = .none
        table.isScrollEnabled = false
        table.backgroundColor = .clear
        table.dataSource = self
        table.allowsSelection = false
        table.register(
            DayCell.self,
            forCellReuseIdentifier: DayCell.reuseId
        )
        return table
    }
}
