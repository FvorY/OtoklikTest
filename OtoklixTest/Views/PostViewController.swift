import UIKit
import Kingfisher

class PostViewController: BaseViewController, InisiateView, PostViewModelDelegate {
    
    @IBOutlet weak var listTableView: UITableView!
    
    @IBOutlet weak var btnCreate: UIButton!
    
    let viewModel = PostViewModel()
    
    weak var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshData), name:NSNotification.Name(rawValue: "refreshData"), object: nil)
        
        self.btnCreate.corners(13)
        
        self.btnCreate.backgroundColor = UIColor(hexString: "#D886FF")
        
        self.setupTable()
        
        viewModel.delegate = self

        self.showLoading()
        viewModel.getData()
    }
    
    @objc func refreshData() {
        viewModel.getData()
    }
    
    func setupTable() {
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
        
        self.listTableView.register(UINib(nibName: "ListPostTableViewCell", bundle: nil), forCellReuseIdentifier: "listPostTableViewCell")
        self.listTableView.register(UINib(nibName: "NotFoundTableView", bundle: nil), forCellReuseIdentifier: "notFoundTableView")
    }
    
    func onSuccess() {
        DispatchQueue.main.async {
            self.firstLoad = false
            self.hideLoading()
            self.listTableView.reloadData()
        }
    }
    
    func onFailed() {
        DispatchQueue.main.async {
            self.firstLoad = false
            self.hideLoading()
            Globals.showAlertWithTitle("Error Load", message: "Check your internet connection!", viewController: self)
        }
    }
    
    func onDeleteSuccess(_ indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.hideLoading()
            self.listTableView.deleteRows(at: [indexPath], with: .none)
            self.listTableView.reloadData()
            Globals.showAlertWithTitle("Success Delete", message: "Delete Data Success!", viewController: self)
        }
    }
    
    func onDeleteFailed() {
        DispatchQueue.main.async {
            self.hideLoading()
            Globals.showAlertWithTitle("Error Delete", message: "Check your internet connection!", viewController: self)
        }
    }

    @IBAction func btnCreateTouched(_ sender: Any) {
        self.coordinator?.postCreate()
    }
    
}

extension PostViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.firstLoad == true {
            return 0
        } else {
            if viewModel.postList.count == 0 {
                return 1
            } else {
                return viewModel.postList.count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if viewModel.postList.count == 0 {
            return tableView.frame.size.height
        } else {
            return 80
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.postList.count == 0 {
            
           let cell = tableView.dequeueReusableCell(withIdentifier: "notFoundTableView", for: indexPath)
            
           return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "listPostTableViewCell", for: indexPath) as! ListPostTableViewCell
            
            let cellinfo = viewModel.postList[indexPath.row]
            
            cell.renderData(cellinfo, indexPath: indexPath)
            
            cell.editTouched = self.editTouched
            
            cell.deleteTouched = self.deleteTouched
            
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellinfo = viewModel.postList[indexPath.row]
        self.coordinator?.postDetail(cellinfo)
    }
    
    func editTouched(_ post: PostModel) {
        self.coordinator?.postEdit(post)
    }
    
    func deleteTouched(_ post: PostModel, indexPath: IndexPath) {
        self.showLoading()
        self.viewModel.deleteData(post.id!, indexPath: indexPath)
    }
}
