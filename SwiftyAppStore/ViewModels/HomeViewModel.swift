//
//  HomeViewModel.swift
//  SwiftyAppStore
//
//  Created by Mico Infante on 7/30/22.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {
    private let repository: HomeRepositoryProtocol
    private var disposeBag: DisposeBag = DisposeBag()

    @Published private(set) var apps: Loadable<[StoreApp]> = .notRequested

    init(repository: HomeRepositoryProtocol = HomeRepository()) {
        self.repository = repository
    }

    func loadApps() {
        apps.setIsLoading(disposeBag: disposeBag)

        repository.fetchGames()
            .ensureTimeSpan(0.5)
            .sinkToResult { result in
            switch result {
            case let .success(apps):
                self.apps = .loaded(apps)
            case let .failure(error):
                self.apps = .failed(error)
            }
        }
        .store(in: disposeBag)
    }
    
}
