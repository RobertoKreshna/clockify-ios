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
    
    var activityGroupedDictionaryKeys = [String]()
    var activityGroupedDictionaryValues = [[Activity]]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.sectionHeaderTopPadding = 0.0 //remove header separator
        registerActivityCell()
    }
    
    func registerActivityCell(){
        let nib = UINib.init(nibName: "ActivityTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
    }
}

//MARK: Table View Data Source
extension ActivityVC: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activityGroupedDictionaryValues[section].count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ActivityTableViewCell
        let activity = activityGroupedDictionaryValues[indexPath.section][indexPath.row]
        cell.titleLabel.text = activity.title
        cell.durationLabel.text = activity.duration
        cell.locationLabel.text = "\(activity.latitude!), \(activity.longitude!)"
        cell.timeLabel.text = TimeAndDate.getStartToEndString(start: activity.start!, end: activity.end!)
        
        cell.layoutMargins = .zero
        cell.separatorInset.left = 16
        cell.separatorInset.right = 16
        return cell
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return activityGroupedDictionaryKeys.count
    }
}

extension ActivityVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 24
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 24))
        header.backgroundColor = .brandBlueDisabled
        let label = UILabel(frame: CGRect(x: 16, y: 4, width: view.frame.size.width, height: 16))
        header.addSubview(label)
        label.text = activityGroupedDictionaryKeys[section]
        label.font = UIFont(name: "NunitoSans7pt-Bold", size: 12)
        label.textColor = .brandYellow
        return header
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
            let activityGroupedDictionary = Dictionary(grouping: activityArray, by: { TimeAndDate.getStringfromDate(start: $0.start!, end: $0.end!) })
            activityGroupedDictionary.keys.forEach { key in
                activityGroupedDictionaryKeys.append(key)
            }
            activityGroupedDictionary.values.forEach { activityList in
                activityGroupedDictionaryValues.append(activityList)
            }
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
}

