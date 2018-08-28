import UIKit

final class FadeViewController: ParentViewController {
    
    override func show(_ vc: UIViewController, sender: Any?) {
        go(vc)
    }
        
    private func go(_ vc: UIViewController) {
        
        vc.modalPresentationCapturesStatusBarAppearance = true
        
        guard let child = childViewControllers.last else {
            view.addSubview(vc.view!)
            addChildViewController(vc)
            vc.view!.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                vc.view!.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                vc.view!.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                vc.view!.trailingAnchor.constraint(equalTo: view.trailingAnchor)
                ])
            vc.didMove(toParentViewController: self)
            didShowViewController?()
            return
        }
        
        view.addSubview(vc.view!)
        vc.view!.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            vc.view!.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            vc.view!.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            vc.view!.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        child.willMove(toParentViewController: nil)
        addChildViewController(vc)
        vc.view!.layoutIfNeeded()
        vc.view!.alpha = 0
        
        UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
            child.view!.alpha = 0
            self.view.layoutIfNeeded()
        }, completion: { (_) in
            child.view!.removeFromSuperview()
            child.removeFromParentViewController()
            UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
                vc.view!.alpha = 1
            }, completion: { _ in
                vc.didMove(toParentViewController: self)
                self.didShowViewController?()
            })
        })
    }
}