//
//  ActivityVC.swift
//  clockify-ios
//
//  Created by Roberto Kreshna on 10/10/23.
//

import UIKit
import CoreData

class ActivityVC: UIViewController {
    var currentUser: User?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var activityArray = [Activity]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        tableView.dataSource = self
    }
}

//MARK: Table View Data Source
extension ActivityVC: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activityArray.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(activityArray[indexPath.row].title!)"
        return cell
    }
}

//MARK: LOAD DATA
extension ActivityVC {
    func loadData(with request: NSFetchRequest<Activity> = Activity.fetchRequest(), predicate: NSPredicate? = nil){
        let categoryPredicate = NSPredicate(format: "belongsTo.email MATCHES %@", currentUser!.email!)
        if let addtionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, addtionalPredicate])
        } else {
            request.predicate = categoryPredicate
        }
        do {
            activityArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
}

