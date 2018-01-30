
//
//  ProjectsViewController.swift
//  Eight25Media_BCS
//
//  Created by Eight25media on 1/28/18.
//  Copyright © 2018 Eight25media. All rights reserved.
//

import UIKit


protocol ProjectsViewControllerDelegate: class {
    func selectedProject(controller: ProjectsViewController, selectedProjectName: String)
}


class ProjectsViewController: UIViewController {

    let projectsCount = 5
    weak var delegate: ProjectsViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension ProjectsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projectsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ID_ProjectsTableViewCell", for: indexPath) as! ProjectsTableViewCell
        cell.projectNameLabel.text = "\(indexPath.row)"
        
        return cell
    }
    
    
}

extension ProjectsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        delegate?.selectedProject(controller: self, selectedProjectName: "\(indexPath.row)")
        dismiss(animated: true, completion: nil)
    }
}
