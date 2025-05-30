//
//  RazorpayCoordinator.swift
//  razorpay
//
//  Created by Sai Kiran on 30/05/25.
//

import Foundation
import Razorpay
import UIKit

class RazorpayCoordinator: NSObject, RazorpayPaymentCompletionProtocolWithData {
    private var razorpay: RazorpayCheckout!
    private let razorpayKey = "rzp_test_defvUfVk6M5YkJ"

    var onPaymentSuccess: (() -> Void)?
    var onPaymentError: ((String) -> Void)?

    override init() {
        super.init()
        razorpay = RazorpayCheckout.initWithKey(razorpayKey, andDelegateWithData: self)
    }

    func startPayment() {
        let options = createPaymentOptions(200)
        openRazorpayUI(with: options)
    }

    private func createPaymentOptions(_ amount: Double) -> [String: Any] {
        return [
            "amount": "\(amount)",
            "currency": "INR",
            "description": "Test Payment",
            "image": "https://your-logo-url.com/logo.png",
            "name": "Frnd App",
            "prefill": [
                "contact": "8299999999",
                "email": "test@example.com"
            ],
            "theme": [
                "color": "#F37254"
            ]
        ]
    }

    private func openRazorpayUI(with options: [String: Any]) {
        guard let rootVC = UIApplication.shared.connectedScenes
                .compactMap({ ($0 as? UIWindowScene)?.keyWindow?.rootViewController })
                .first else {
            print("Failed to get root view controller")
            return
        }

        razorpay.open(options, displayController: rootVC)
    }

    func onPaymentSuccess(_ payment_id: String, andData response: [AnyHashable : Any]?) {
        print("Payment success: \(payment_id)")
        onPaymentSuccess?()
    }

    func onPaymentError(_ code: Int32, description str: String, andData response: [AnyHashable : Any]?) {
        print("Payment error: \(str)")
        onPaymentError?(str)
    }
}
