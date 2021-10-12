//
//  RoasterViewController.swift
//  AirHolland
//
//  Created by Sarvesh Suryavanshi on 12/10/21.
//

import UIKit

class RoasterViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel: RoasterViewModelProtocol?
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Refresh Roaster")
        refreshControl.addTarget(self, action: #selector(refreshView), for: .valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupTableView()
        self.loadRoaster()
    }
}

private extension RoasterViewController {
    
    func setupTableView() {
        self.tableView.estimatedRowHeight = 50.0
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedSectionHeaderHeight = 20.0
        self.tableView.sectionHeaderHeight = UITableView.automaticDimension
        
        if #available(iOS 10.0, *) {
            self.tableView.refreshControl = self.refreshControl
        } else {
            tableView.addSubview(self.refreshControl)
        }
    }
    
    @objc func refreshView() {
        self.loadRoaster()
    }
}

extension RoasterViewController: RoasterViewProtocol {
    
    func loadRoaster() {
        self.viewModel?.loadRoaster()
    }
    
    func updateUI() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            if self.refreshControl.isRefreshing { self.refreshControl.endRefreshing() }
        }
    }
}

extension RoasterViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.viewModel?.sectionDisplayDate(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RoasterCell.reuseIdentifier, for: indexPath) as? RoasterCell else { return UITableViewCell() }
        if let roaster = self.viewModel?.roaster(at: indexPath) {
            cell.configure(with: roaster)
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel?.rows(in: section) ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        self.viewModel?.sections ?? 0
    }
}
