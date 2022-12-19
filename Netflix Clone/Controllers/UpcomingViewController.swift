//
//  UpcomingViewController.swift
//  Netflix Clone
//
//  Created by Caner Çağrı on 29.11.2022.
//

import UIKit

class UpcomingViewController: UIViewController {
    
    private  var titles: [Title] = [Title]()
    
    private let upcomingTableView: UITableView = {
        var tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
        configureTableView()
        fetchUpcoming()
    }
    
    private func configureViewController() {
        title = "Upcoming"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
    
    private func configureTableView() {
        view.addSubview(upcomingTableView)
        upcomingTableView.delegate = self
        upcomingTableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        upcomingTableView.frame = view.bounds
    }
    
    private func fetchUpcoming() {
        APICaller.shared.getUpcomingMovies { [weak self] result in
            switch result {
            case .success(let title):
                self?.titles = title
                DispatchQueue.main.async {
                    self?.upcomingTableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension UpcomingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = titles[indexPath.row].original_name ?? titles[indexPath.row].original_title ?? "Unknown"
        return cell
    }
    
    
}
