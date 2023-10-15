//
//  ActivityVC.swift
//  clockify-ios
//
//  Created by Roberto Kreshna on 10/10/23.
//

import UIKit
import CoreData
import DropDown

class ActivityVC: UIViewController {
    var currentUser: User?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var activityArray = [Activity]()
    
    var activityGroupedDictionaryKeys = [String]()
    var activityGroupedDictionaryValues = [[Activity]]()
    
    let sortDropdown = DropDown()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var sortButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        setupTableViewAndSearchBar()
        customizeTableView()
        registerActivityCell()
        customizeSearchBar()
        customizeSortButton()
        initSortDropdown()
    }
    
    func setupTableViewAndSearchBar(){
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
    }
    
    func registerActivityCell(){
        let nib = UINib.init(nibName: "ActivityTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
    }
    
    func customizeSearchBar(){
        //create button
        let buttonView = UIButton(frame:CGRect(x: 0, y: 4, width: 32, height: 32))
        buttonView.setImage(UIImage(named: "search"), for: .normal)
        buttonView.addTarget(self, action: #selector(searchIconPressed), for: .touchUpInside)
        
        //add padding
        let rightView: UIView = UIView(frame:CGRect(x: 0, y: 0, width: 40, height: 40))
        rightView.backgroundColor = searchBar.backgroundColor
        rightView.addSubview(buttonView)
        let leftView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 40))
        searchBar.rightView = rightView
        searchBar.rightViewMode = .always
        searchBar.leftView = leftView
        searchBar.leftViewMode = .always
        
        //rounded corner
        searchBar.layer.cornerRadius = 12
        searchBar.clipsToBounds = true
    }
    
    func customizeTableView(){
        tableView.sectionHeaderTopPadding = 0.0 //remove header separator
        tableView.sectionFooterHeight = 0
    }
    
    func customizeSortButton(){
        sortButton.configuration?.baseBackgroundColor = .brandBlueDisabled
        sortButton.layer.cornerRadius = 16
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
        let activityPredicate = NSPredicate(format: "belongsTo.email MATCHES %@", currentUser!.email!)
        if let addtionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [activityPredicate, addtionalPredicate])
        } else {
            request.predicate = activityPredicate
        }
        request.sortDescriptors = [NSSortDescriptor(key: "end", ascending: true)]
        do {
            activityArray = try context.fetch(request)
            let activityGroupedDictionary = Dictionary(grouping: activityArray, by: { TimeAndDate.getStringfromDate(start: $0.start!, end: $0.end!) })
            let sortedGrouped = activityGroupedDictionary.sorted(by: { TimeAndDate.getDateFromStringToCompare(date:$0.key)! > TimeAndDate.getDateFromStringToCompare(date:$1.key)!})
            activityGroupedDictionaryKeys = [String]()
            activityGroupedDictionaryValues = [[Activity]]()
            sortedGrouped.forEach { Element in
                activityGroupedDictionaryKeys.append(Element.key)
                activityGroupedDictionaryValues.append(Element.value)
            }
        } catch {
            print("Error fetching data from context \(error)")
        }
        tableView.reloadData()
    }
}

//MARK: SearchBar methods
extension ActivityVC: UITextFieldDelegate {
    
    @objc func searchIconPressed(_ sender: UIButton) {
        searchBar.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if(textField.text != ""){
            let request : NSFetchRequest<Activity> = Activity.fetchRequest()
            let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
            loadData(with: request, predicate: predicate)
        }
        else {
            loadData()
        }
    }
    
}

//MARK: Sorting
extension ActivityVC {
    func initSortDropdown(){
        //data
        sortDropdown.dataSource = [ "Latest Date", "Nearby" ]
        //location
        sortDropdown.anchorView = sortButton
        sortDropdown.direction = .bottom
        sortDropdown.bottomOffset = CGPoint(x: 0, y: 48)
        //ui
        sortDropdown.width = sortButton.bounds.width
        sortDropdown.backgroundColor = .brandAccent
        sortDropdown.textColor = .brandBlue
        sortDropdown.cornerRadius = 8
        //action when pressed
        sortDropdown.selectionAction = { (index: Int, item: String) in
            if let font = UIFont(name: "NunitoSans7pt-Regular", size: 14){
                self.sortButton.setAttributedTitle(
                    NSAttributedString(
                        string: item,
                        attributes: [NSAttributedString.Key.font : font]
                    ),
                    for: .normal
                )
            }
        }
    }
    
    @IBAction func sortButtonPressed(){
        sortDropdown.show()
    }
}

