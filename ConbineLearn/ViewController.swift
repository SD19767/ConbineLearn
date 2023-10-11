//
//  ViewController.swift
//  ConbineLearn
//
//  Created by Alvin Tseng on 2023/10/4.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    var subscriptions = Set<AnyCancellable>()

    @IBOutlet weak var firstSumTextField: UITextField!
    @IBOutlet weak var secondSumTextField: UITextField!
    @IBOutlet weak var answerLabel: UILabel!
    

    
    
    var viewModel = ViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.$answer
            .sink { [weak self] answer in
                self?.answerLabel.text = String(answer)
            }
            .store(in: &subscriptions)
    }

    
    @IBAction func touchUpInsideStartButton(_ sender: Any) {

    }
}

class ViewModel {
    var subscriptions = Set<AnyCancellable>()
    @Published var answer = 0
}
