//
//  ListDetail.swift
//  DemoCoreData
//
//  Created by DCS on 17/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class ListDetail: UIViewController {

    private var empArray = [Employee]()
    
    private let empTableView = UITableView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        empArray = coredatahandler.shared.fetch()
        empTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Employees"
        
        view.addSubview(empTableView)
        
        let addItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewEmployee))
        navigationItem.setRightBarButton(addItem, animated: true)
        
        setupTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        empTableView.frame = view.bounds
    }
    
    @objc private func addNewEmployee() {
         let vc = ViewController()
         navigationController?.pushViewController(vc, animated: true)
    }
}

extension ListDetail : UITableViewDataSource, UITableViewDelegate {
    
    private func setupTableView() {
        empTableView.register(UITableViewCell.self, forCellReuseIdentifier: "emp")
        empTableView.delegate = self
        empTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return empArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "emp", for: indexPath)
        let emp = empArray[indexPath.row]
        cell.textLabel?.text = "\(emp.ename!) \t | \t \(emp.age) \t | \t \(emp.phone!)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = ViewController()
        vc.employee = empArray[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let emp = empArray[indexPath.row]
        coredatahandler.shared.delete(emp: emp){
            self.empArray.remove(at:indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

