//
//  HomeViewModel.swift
//  SwiftyAppStore
//
//  Created by Mico Infante on 7/30/22.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject, LoadableObject{
//    @Published var apps: AnyPublisher<[StoreApp], Error>
    private let repository: HomeRepositoryProtocol
    var cancellableSet: Set<AnyCancellable> = []
    private var disposeBag: DisposeBag = DisposeBag()
    @Published private(set) var apps: Loadable<[StoreApp]> = .notRequested

    @Published private(set) var state: LoadingState<[StoreApp]> = .idle

    init(repository: HomeRepositoryProtocol = HomeRepository()) {
        self.repository = repository
    }

    func loadApps() {
        print("Appeared")
        apps.setIsLoading(disposeBag: disposeBag)

//        repository.fetchGames().sinkToLoadable {
//            self.apps = $0
//        }
//        .store(in: disposeBag)
        repository.fetchGames()
            .ensureTimeSpan(0.5)
            .sinkToResult { result in
            switch result {
            case let .success(apps):
                print("Got apps \(apps.count)")
                self.apps = .loaded(apps)
            case let .failure(error):
                self.apps = .failed(error)
            }
        }
        .store(in: disposeBag)

//        repository.fetchGames().ensureTimeSpan(0.5)
//            .sinkToLoadable {
//                self.apps = $0
//            }.store(in: disposeBag)
            
//        repository.fetchGames().sinkToLoadable {
//            self.state = $0
//        }
    }
    
}
