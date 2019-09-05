import UIKit
import Marshroute

public final class PhotoLibraryV2MarshrouteAssemblyImpl: BasePaparazzoAssembly, PhotoLibraryV2MarshrouteAssembly {
    
    typealias AssemblyFactory = MediaPickerMarshrouteAssemblyFactory & NewCameraMarshrouteAssemblyFactory
    
    private let assemblyFactory: AssemblyFactory
    
    init(assemblyFactory: AssemblyFactory, theme: PaparazzoUITheme, serviceFactory: ServiceFactory) {
        self.assemblyFactory = assemblyFactory
        super.init(theme: theme, serviceFactory: serviceFactory)
    }
    
    public func module(
        mediaPickerData: MediaPickerData,
        selectedItems: [PhotoLibraryItem],
        maxSelectedItemsCount: Int?,
        routerSeed: RouterSeed,
        isMetalEnabled: Bool,
        isNewFlowPrototype: Bool,
        configure: (PhotoLibraryV2Module) -> ()
    ) -> UIViewController {
        
        let photoLibraryItemsService = PhotoLibraryItemsServiceImpl(photosOrder: .reversed)
        
        let cameraService = serviceFactory.cameraService(initialActiveCameraType: .back)
        cameraService.isMetalEnabled = isMetalEnabled
        
        let interactor = PhotoLibraryV2InteractorImpl(
            mediaPickerData: mediaPickerData,
            selectedItems: selectedItems,
            maxSelectedItemsCount: maxSelectedItemsCount,
            photoLibraryItemsService: photoLibraryItemsService,
            cameraService: cameraService,
            deviceOrientationService: DeviceOrientationServiceImpl(),
            canRotate: UIDevice.current.userInterfaceIdiom == .pad
        )
        
        let router = PhotoLibraryV2MarshrouteRouter(
            assemblyFactory: assemblyFactory,
            routerSeed: routerSeed
        )
        
        let presenter = PhotoLibraryV2Presenter(
            interactor: interactor,
            router: router,
            overridenTheme: theme,
            isMetalEnabled: isMetalEnabled,
            isNewFlowPrototype: isNewFlowPrototype
        )
        
        let viewController = PhotoLibraryV2ViewController(isNewFlowPrototype: isNewFlowPrototype)
        viewController.addDisposable(presenter)
        viewController.setTheme(theme)
        
        presenter.view = viewController
        
        configure(presenter)
        
        return viewController
    }
}
