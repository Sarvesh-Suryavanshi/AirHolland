//
//  RoasterViewController.swift
//  AirHolland
//
//  Created by Sarvesh Suryavanshi on 12/10/21.
//

import UIKit
import CoreData

/// This view is responsible for showing roaster information to the crew
class RoasterViewController: UIViewController {
    
    //MARK: - IBOutlets Properties

    @IBOutlet weak var tableView: UITableView!

    //MARK: - Properties

    var viewModel: RoasterViewModelProtocol?
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Refresh Duty Roaster")
        refreshControl.addTarget(self, action: #selector(refreshView), for: .valueChanged)
        return refreshControl
    }()
    
    //MARK: - View Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadRoaster()
        self.setupTableView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let detailsView = segue.destination as? RoasterDetailsViewController,
            let indexPath = sender as? IndexPath,
            let roaster = self.viewModel?.roaster(at: indexPath)
        else { return }
            detailsView.configure(with: roaster)
    }
}

//MARK: - Roaster View Protocol Methods

extension RoasterViewController: RoasterViewProtocol {
  
    func loadRoaster() {
        self.viewModel?.loadRoaster()
    }
    
    func startedLoadingRoasterDetails() {
        if !self.refreshControl.isRefreshing {
            self.showLoadingIndicator()
        }
    }
    
    func updateUI() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            if self.refreshControl.isRefreshing {
                self.refreshControl.endRefreshing()
            } else {
                self.dismissLoadingIndicator()
            }
        }
    }
}

//MARK: - UITableView DataSource Methods

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

//MARK: - UITableView Delegate Methods

extension RoasterViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ShowRoasterDetails", sender: indexPath)
    }
}

//MARK: - Private Extension

private extension RoasterViewController {
    
    func setupTableView() {
        self.tableView.estimatedRowHeight = 75.0
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
