//
//  LoadingSpinner.swift
//  Movie Discovery App
//
//  Created by Takudzwa Raisi on 2025/02/20.
//
import SwiftUI

struct LoadingSpinner: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
            .scaleEffect(2)
    }
}
