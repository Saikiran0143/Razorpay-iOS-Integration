//
//  RazorpayView.swift
//  razorpay
//
//  Created by Sai Kiran on 29/04/25.
//

import SwiftUI

struct RazorpayView: View {
    @StateObject private var viewModel = RazorpayViewModel()

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            VStack {
                Button("Pay through Razorpay") {
                    viewModel.startPayment()
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
        .sheet(isPresented: $viewModel.showSheet) {
            BottomSheetContent(
                message: viewModel.paymentMessage,
                isSuccess: viewModel.isSuccess,
                onDismiss: { viewModel.showSheet = false }
            )
            .presentationDetents([.height(300)])
            .presentationDragIndicator(.visible)
        }
    }
}


struct BottomSheetContent: View {
    let message: String
    let isSuccess: Bool
    let onDismiss: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: isSuccess ? "checkmark.seal.fill" : "xmark.octagon.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .foregroundColor(isSuccess ? .green : .red)

            Text(message)
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Button("Dismiss", action: onDismiss)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}
