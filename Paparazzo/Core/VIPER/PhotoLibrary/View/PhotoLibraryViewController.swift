import UIKit

final class PhotoLibraryViewController: PaparazzoViewController, PhotoLibraryViewInput, ThemeConfigurable {
    
    typealias ThemeType = PhotoLibraryUITheme
    
    private let photoLibraryView = PhotoLibraryView()
    
    // MARK: - UIViewController
    
    override func loadView() {
        view = photoLibraryView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onViewDidLoad?()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
        UIApplication.shared.setStatusBarHidden(true, with: animated ? .fade : .none)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - ThemeConfigurable
    
    func setTheme(_ theme: ThemeType) {
        self.theme = theme
        photoLibraryView.setTheme(theme)
    }
    
    // MARK: - PhotoLibraryViewInput
    
    var onItemSelect: ((PhotoLibraryItem) -> ())?
    var onViewDidLoad: (() -> ())?
    
    var onTitleTap: (() -> ())? {
        get { return photoLibraryView.onTitleTap }
        set { photoLibraryView.onTitleTap = newValue }
    }
    
    var onPickButtonTap: (() -> ())? {
        get { return photoLibraryView.onConfirmButtonTap }
        set { photoLibraryView.onConfirmButtonTap = newValue }
    }
    
    var onCancelButtonTap: (() -> ())? {
        get { return photoLibraryView.onDiscardButtonTap }
        set { photoLibraryView.onDiscardButtonTap = newValue }
    }
    
    var onAccessDeniedButtonTap: (() -> ())? {
        get { return photoLibraryView.onAccessDeniedButtonTap }
        set { photoLibraryView.onAccessDeniedButtonTap = newValue }
    }
    
    var onDimViewTap: (() -> ())? {
        get { return photoLibraryView.onDimViewTap }
        set { photoLibraryView.onDimViewTap = newValue }
    }
    
    @nonobjc func setTitle(_ title: String) {
        photoLibraryView.setTitle(title)
    }
    
    func deleteAllItems() {
        photoLibraryView.deleteAllItems()
    }
    
    func applyChanges(_ changes: PhotoLibraryViewChanges, animated: Bool, completion: (() -> ())?) {
        photoLibraryView.applyChanges(changes, animated: animated, completion: completion)
    }
    
    func setCanSelectMoreItems(_ canSelectMoreItems: Bool) {
        photoLibraryView.canSelectMoreItems = canSelectMoreItems
    }
    
    func setDimsUnselectedItems(_ dimUnselectedItems: Bool) {
        photoLibraryView.dimsUnselectedItems = dimUnselectedItems
    }
    
    func deselectAllItems() {
        photoLibraryView.deselectAndAdjustAllCells()
    }
    
    func scrollToBottom() {
        photoLibraryView.scrollToBottom()
    }
    
    func setAccessDeniedViewVisible(_ visible: Bool) {
        photoLibraryView.setAccessDeniedViewVisible(visible)
    }
    
    func setAccessDeniedTitle(_ title: String) {
        photoLibraryView.setAccessDeniedTitle(title)
    }
    
    func setAccessDeniedMessage(_ message: String) {
        photoLibraryView.setAccessDeniedMessage(message)
    }
    
    func setAccessDeniedButtonTitle(_ title: String) {
        photoLibraryView.setAccessDeniedButtonTitle(title)
    }
    
    func setProgressVisible(_ visible: Bool) {
        photoLibraryView.setProgressVisible(visible)
    }
    
    func setAlbums(_ albums: [PhotoLibraryAlbumCellData]) {
        photoLibraryView.setAlbums(albums)
    }
    
    func showAlbumsList() {
        photoLibraryView.showAlbumsList()
    }
    
    func hideAlbumsList() {
        photoLibraryView.hideAlbumsList()
    }
    
    func toggleAlbumsList() {
        photoLibraryView.toggleAlbumsList()
    }
    
    // MARK: - Private
    
    private var theme: PhotoLibraryUITheme?
    
    @objc private func onCancelButtonTap(_ sender: UIBarButtonItem) {
        onCancelButtonTap?()
    }
    
    @objc private func onPickButtonTap(_ sender: UIBarButtonItem) {
        onPickButtonTap?()
    }
}
