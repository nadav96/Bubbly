import Foundation

class CountDown {
    var step: Int = 0
    var timer: Timer?
    var runCallback: ((Int) -> Void)?
    var doneCallback: (() -> Void)?

    func start(runCallback: @escaping ((Int) -> Void), doneCallback: @escaping (() -> Void)) {
        self.step = 3
        self.runCallback = runCallback
        self.doneCallback = doneCallback
        self.runCallback?(self.step)
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCountdown), userInfo: nil, repeats: true)
    }

    @objc func updateCountdown() {
        self.step -= 1
        
        if self.step == -1 {
            self.timer?.invalidate()
            self.doneCallback?()
        }
        else {
            self.runCallback?(self.step)
        }
        
    }
}
