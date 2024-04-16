import UIKit
import CoreData
import Foundation

class TeachersViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var teachersTableView: UITableView!
    
    var nameOfTeacher: String? = ""
    var lastNameOfTeacher: String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    @IBAction func addButtonTapped(_ sender: UIButton) {
        
        nameOfTeacher = nameTextField.text
        lastNameOfTeacher = lastNameTextField.text 
        StorageManager.shared.addTeacher(nameOfTeacher, lastname: lastNameOfTeacher)
        teachersTableView.reloadData()
    }
    private func setupTableView() {
        teachersTableView.dataSource = self
        teachersTableView.delegate = self
        registerCell()
    }
    private func registerCell() {
        teachersTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    var selectedTitle: String?
    
}
extension TeachersViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let teacherVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TeacherViewController") as? TeacherViewController else { return }
        if let cell = tableView.cellForRow(at: indexPath) {
                selectedTitle = cell.textLabel?.text
            }
        teacherVC.selectedTitle = selectedTitle
                navigationController?.pushViewController(teacherVC, animated: true)
        }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let teachers = StorageManager.shared.fetchTeachers() {
            return teachers.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if let teachers = StorageManager.shared.fetchTeachers() {
            if indexPath.row < teachers.count {
                let teacher = teachers[indexPath.row]
                cell.textLabel?.text = teacher.name
            }
        }
        return cell
    }
}
