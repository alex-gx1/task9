import UIKit
import CoreData
import Foundation

class StudentsViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var studentsTableView: UITableView!
    
    var nameOfStudent: String?
    var ageOfStudent: Int16 = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    @IBAction func addButtonTapped() {
        
        nameOfStudent = nameTextField.text
        if let ageString = ageTextField.text, let age = Int(ageString) {
            let ageAsInt16: Int16 = Int16(age)
            StorageManager.shared.addStudent(nameOfStudent, studentAge: ageAsInt16)
        } else {
            ageTextField.text = ""
        }
        studentsTableView.reloadData()
    }
    private func setupTableView() {
        studentsTableView.dataSource = self
        studentsTableView.delegate = self
        registerCell()
    }
    private func registerCell() {
        studentsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    var selectedStudentTitle: String?
}
extension StudentsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let studentVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "StudentViewController") as? StudentViewController else { return }
        if let cell = tableView.cellForRow(at: indexPath) {
            selectedStudentTitle = cell.textLabel?.text
            }
        studentVC.selectedStudentTitle = selectedStudentTitle
                navigationController?.pushViewController(studentVC, animated: true)
        }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let students = StorageManager.shared.fetchStudents() {
            return students.count
        } else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = studentsTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if let students = StorageManager.shared.fetchStudents() {
            if indexPath.row < students.count {
                let student = students[indexPath.row]
                cell.textLabel?.text = student.studentName
            }
        }
        return cell
    }
}
