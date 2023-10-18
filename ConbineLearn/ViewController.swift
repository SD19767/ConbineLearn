//
//  ViewController.swift
//  ConbineLearn
//
//  Created by Alvin Tseng on 2023/10/4.
//
// test
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
        viewModel.touchUpInsideStartEvent.send((firstSumTextField.text, secondSumTextField.text))
    }
}

class ViewModel {
    var subscriptions = Set<AnyCancellable>()
    @Published var answer = 0
    var touchUpInsideStartEvent = PassthroughSubject<(String?, String?), Never>()
    
    init() {
        binding()
    }
    
    func binding() {
        touchUpInsideStartEvent
            .map(covertTuple)
            .map(addTwoSums)
            .assign(to: &$answer)
    }
    
    func addTwoSums(sums: (Int?, Int?)) -> Int {
        (sums.0 ?? 0) + (sums.1 ?? 0)
    }
    
    func covertTuple(numberStrings: (String?, String?)) -> (Int?, Int?) {
        let firstNumber = convert(numberString: numberStrings.0)
        let secondNumber = convert(numberString: numberStrings.0)
        return (firstNumber, secondNumber)
    }
    
    func convert(numberString: String?) -> Int? {
        if let numberString = numberString ,let number = Int(numberString),
           number < 10 {
            return number
        }
        return nil
    }

}
