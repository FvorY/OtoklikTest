import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.interactivePopGestureRecognizer?.delegate = nil
        self.navigationController.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationController.navigationItem.backBarButtonItem?.isEnabled = true
        
        let navController = self.navigationController
        navController.setNavigationBarHidden(true, animated: false)
    }
    
    func start() {
        let vc = PostViewController.instantiateXib()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func postDetail(_ data: PostModel) {
        let vc = PostDetailViewController.instantiateXib()
        vc.coordinator = self
        vc.viewModel.postDetail = data
        vc.modalPresentationStyle = .overCurrentContext
        
        navigationController.present(vc, animated: false)
    }
    
    func postCreate() {
        let vc = PostActionViewController.instantiateXib()
        vc.coordinator = self
        vc.modalPresentationStyle = .overCurrentContext
        
        navigationController.present(vc, animated: false)
    }
    
    func postEdit(_ data: PostModel) {
        let vc = PostActionViewController.instantiateXib()
        vc.postData = data
        vc.coordinator = self
        vc.modalPresentationStyle = .overCurrentContext
        
        navigationController.present(vc, animated: false)
    }
    
    func dismiss() {
        self.navigationController.popToRootViewController(animated: true)
    }
}
