import UIKit
import CoreData
import Foundation

class StudentViewController: UIViewController {
    
    @IBOutlet weak var labelNameStudent: UILabel!
    @IBOutlet weak var labelAgeStudent: UILabel!
    @IBOutlet weak var labelNameTeacher: UILabel!
    var selectedStudentTitle: String?
    var selectedStudent: Student?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedStudent = StorageManager.shared.fetchStudent(with: selectedStudentTitle)
        if let student = selectedStudent {
            labelNameStudent.text = student.studentName
            labelAgeStudent.text = String(student.studentAge)
            if let student = selectedStudent {
                if let teacherName = StorageManager.shared.getTeacherName(for: student) {
                    labelNameTeacher.text = teacherName
                } else {
                    labelNameTeacher.text = "нет преподавателя"
                }
            }
        }
        
    }
    
}
