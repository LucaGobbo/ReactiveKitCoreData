//
//  FetchedResultsControllerSectionObserver.swift
//
//
//  Created by Luca Gobbo on 21/04/2020.
//

import CoreData
import Foundation
import ReactiveKit

public final class FetchedResultsControllerSectionObserver<T: NSManagedObject>: NSObject, NSFetchedResultsControllerDelegate {
    typealias Observer =  AtomicObserver<[NSFetchedResultsSectionInfo], ReactiveKitCoreData.Error>

    private let observer: Observer
    private let fetchedResultsController: NSFetchedResultsController<T>

    init(observer: Observer, fetchedResultsController: NSFetchedResultsController<T>) {
        self.observer = observer
        self.fetchedResultsController = fetchedResultsController

        super.init()

        self.fetchedResultsController.delegate = self

        do {
            try self.fetchedResultsController.performFetch()
        } catch {
            observer.receive(completion: .failure(.fetchFailed(error)))
        }

        sendNextElement()
    }

    private func sendNextElement() {
        let sections = fetchedResultsController.sections ?? []
        observer.receive(sections)
    }

    public func controllerDidChangeContent(_: NSFetchedResultsController<NSFetchRequestResult>) {
        sendNextElement()
    }
}

// MARK: - Disposable

extension FetchedResultsControllerSectionObserver: Disposable {
    public var isDisposed: Bool { fetchedResultsController.delegate == nil }

    /// Delegate implementation for `Disposable`
    /// required methods - This is kept in here
    /// to make `fetchedResultsController` private.
    public func dispose() {
        fetchedResultsController.delegate = nil
    }
}
