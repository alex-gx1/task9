import UIKit
import CoreData
import Foundation

class TeacherViewController: UIViewController {
    
    @IBOutlet weak var labelNameTeacher: UILabel!
    @IBOutlet weak var labelLastNameTeacher: UILabel!
    
    @IBOutlet weak var allStudentTableView: UITableView!
    @IBOutlet weak var addedStudentTextVeiw: UITextView!
    
    var selectedTitle: String?
    var selectedTeacher: Teacher?
    var selectedStudents: [Student] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedTeacher = StorageManager.shared.fetchTeacher(with: selectedTitle)
        if let teacher = selectedTeacher {
            labelNameTeacher.text = teacher.name
            labelLastNameTeacher.text = teacher.lastName
            setupTableView()
        }
        loadSelectedStudents()
    }
    private func loadSelectedStudents() {
            guard let selectedTeacher = selectedTeacher else {
                return
            }
            if let students = StorageManager.shared.fetchStudents(for: selectedTeacher) {
                selectedStudents = students
                updateTextViewWithStudents()
            } else {
                print("Failed to load students for the selected teacher")
            }
        }
    private func updateTextViewWithStudents() {
            let studentNames = selectedStudents.compactMap { $0.studentName }
            let studentsString = studentNames.joined(separator: "\n")
            addedStudentTextVeiw.text = studentsString
        }
    
    private func setupTableView() {
        allStudentTableView.dataSource = self
        allStudentTableView.delegate = self
        registerCell()
    }
    private func registerCell() {
        allStudentTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
}
extension TeacherViewController:  UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
            
            guard let students = StorageManager.shared.fetchStudents(),
                  indexPath.row < students.count,
                  let selectedTeacher = selectedTeacher else {
                return
            }
            let selectedStudent = students[indexPath.row]
            StorageManager.shared.addStudentToTeacher(selectedStudent, teacher: selectedTeacher)
            loadSelectedStudents()
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
        let cell = allStudentTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if let students = StorageManager.shared.fetchStudents() {
            if indexPath.row < students.count {
                let student = students[indexPath.row]
                cell.textLabel?.text = student.studentName
            }
        }
        return cell
    }
}
