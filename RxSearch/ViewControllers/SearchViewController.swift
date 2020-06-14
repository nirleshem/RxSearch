//
//  ViewController.swift
//  RxSearch
//
//  Created by Nir Leshem on 12/06/2020.
//  Copyright © 2020 Nir Leshem. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SearchViewController: UIViewController {

    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20.0
        stackView.addArrangedSubview(searchBar)
        stackView.addArrangedSubview(filterView)
        stackView.addArrangedSubview(tableView)
        return stackView
    }()
    
    lazy var searchBar: UISearchBar = {
        let search = UISearchBar()
        search.placeholder = "Search..."
        return search
    }()
    
    lazy var rightFilterButton: UIButton = {
        let button = UIButton()
        button.setTitle("Score", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius =  8
        button.addTarget(self, action: #selector(rightButtonAction), for: .touchUpInside)
        return button
    }()
    
    lazy var leftFilterButton: UIButton = {
        let button = UIButton()
        button.setTitle("Name", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius =  8
        button.addTarget(self, action: #selector(leftButtonAction), for: .touchUpInside)
        return button
    }()
    
    lazy var filterView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(leftFilterButton)
        stackView.addArrangedSubview(rightFilterButton)
        return stackView
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(MovieTableViewCell.nib(), forCellReuseIdentifier: MovieTableViewCell.id)
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 60.0
        table.tableFooterView = UIView()
        return table
    }()
    
    let disposeBag = DisposeBag()
    var viewModel: SearchViewModel?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
        setupRx()
    }
    
    private func setupUI() {
        view.addSubview(mainStackView)
        mainStackView.fillSuperview()
        setActiveFilter(currentFilter: viewModel?.currentFilter)
    }
    
    private func setupRx() {
        guard let viewModel = viewModel else { return }
        
        searchBar
            .rx
            .text
            .orEmpty
            .bind(to: viewModel.searchQuery)
            .disposed(by: disposeBag)

        
        viewModel.dataSource
            .bind(to: tableView.rx.items(cellIdentifier: MovieTableViewCell.id)) { (index, viewModel: MovieViewModelable, cell) in
                if let movieCell = cell as? MovieTableViewCell, let vm = viewModel as? MovieViewModel {
                    movieCell.configure(viewModel: vm)
                }
        }
        .disposed(by: disposeBag)
        
        
        viewModel.searchQuery.asDriver()
            .debounce(RxTimeInterval.milliseconds(250))
            .distinctUntilChanged()
            .drive(onNext: { query in
                if !query.isEmpty {
                    viewModel.search(with: query)
                }
        }).disposed(by: disposeBag)
    }
    
    @objc private func rightButtonAction() {
        viewModel?.currentFilter = .score
        setActiveFilter(currentFilter: viewModel?.currentFilter)
    }
    
    @objc private func leftButtonAction() {
        viewModel?.currentFilter = .name
        setActiveFilter(currentFilter: viewModel?.currentFilter)
    }
    
    private func setActiveFilter(currentFilter: FilterState?) {
        guard let filter = currentFilter else { return }
        viewModel?.currentFilter = filter
        toggleButtonsUI(currentFilter: filter)
        sortIfNeeded()
    }
    
    private func toggleButtonsUI(currentFilter: FilterState?) {
        let rightTitleColor: UIColor = currentFilter == .name ? .black : .white
        let leftTitleColor: UIColor = currentFilter == .name ? .white : .black
        rightFilterButton.backgroundColor = currentFilter == .name ? .white : UIColor.getButtonBgColorOn()
        rightFilterButton.setTitleColor(rightTitleColor, for: .normal)
        leftFilterButton.backgroundColor = currentFilter == .name ? UIColor.getButtonBgColorOn() : .white
        leftFilterButton.setTitleColor(leftTitleColor, for: .normal)
    }
    
    private func sortIfNeeded() {
        if let text = searchBar.text, let viewModel = viewModel {
            if !text.isEmpty {
                viewModel.sort()
            }
        }
    }
}

