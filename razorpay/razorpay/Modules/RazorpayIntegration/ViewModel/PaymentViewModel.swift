//
//  RazorpayCoordinator.swift
//  razorpay
//
//  Created by Sai Kiran on 29/04/25.
//

import Foundation
import SwiftUI

class RazorpayViewModel: ObservableObject {
    private let coordinator = RazorpayCoordinator()

    @Published var showSheet = false
    @Published var paymentMessage = ""
    @Published var isSuccess = false

    init() {
        coordinator.onPaymentSuccess = {
            DispatchQueue.main.async {
                self.paymentMessage = "Payment Successful!"
                self.isSuccess = true
                self.showSheet = true
            }
        }
        coordinator.onPaymentError = { error in
            DispatchQueue.main.async {
                self.paymentMessage = "Payment Failed: \(error)"
                self.isSuccess = false
                self.showSheet = true
            }
        }
    }

    func startPayment() {
        coordinator.startPayment()
    }
}
