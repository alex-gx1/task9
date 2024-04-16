import UIKit
import CoreData
import Foundation

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction private func teachersButtonTapped() {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let secondVC = mainStoryBoard.instantiateViewController(withIdentifier: "TeachersViewController") as? TeachersViewController else { return }
        navigationController?.pushViewController(secondVC, animated: true)
    }
    @IBAction private func studentsButtonTapped() {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let thirdVC = mainStoryBoard.instantiateViewController(withIdentifier: "StudentsViewController") as? StudentsViewController else { return }
        navigationController?.pushViewController(thirdVC, animated: true)
    }
}

