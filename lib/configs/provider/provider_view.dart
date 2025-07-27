import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Define an abstract class named ProviderView that extends StatefulWidget
/// The generic type T must extend ChangeNotifier
abstract class ProviderView<T extends ChangeNotifier> extends StatefulWidget {
  /// Constructor for the ProviderView, calling the superclass constructor
  const ProviderView({super.key});
  /// Abstract method that must be implemented in subclasses
  /// This method will build the widget tree
  Widget builder(BuildContext context, T viewModel, Widget? child);
  /// Optional method that can be overridden in subclasses
  /// This method is called when the view model is ready
  void onViewModelReady(T viewModel) {}
  /// Abstract method that must be implemented in subclasses
  /// This method will create and return the view model
  T viewModelBuilder(BuildContext context);
  void tickerProviderStateMixin(T viewModel,TickerProviderStateMixin tickerProviderStateMixin){}
  void didChangeAppLifecycleState(AppLifecycleState state,T viewModel){}
  @override
// ignore: library_private_types_in_public_api
  _ProviderViewState<T> createState() => _ProviderViewState<T>();
}
/// Define the state class for ProviderView
class _ProviderViewState<T extends ChangeNotifier> extends State<ProviderView<T>> with TickerProviderStateMixin,WidgetsBindingObserver  {
  /// Declare a variable to hold the view model
  late T viewModel;
  /// Override the initState method
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    /// Initialize the view model by calling the viewModelBuilder method from the widget
    viewModel = widget.viewModelBuilder(context);

    widget.tickerProviderStateMixin(viewModel,this);

    /// Call the onViewModelReady method from the widget with the view model
    widget.onViewModelReady(viewModel);

    /// Call the superclass's initState method
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {

    }

    if (state == AppLifecycleState.paused) {

    }
    widget.didChangeAppLifecycleState(state, viewModel);
  }

  /// Override the build method
  @override
  Widget build(BuildContext context) {
    ///Return a ChangeNotifierProvider to provide the view model to the widget tree
    return ChangeNotifierProvider<T>(
      /// Create the view model
      create: (context) => viewModel,
      /// Use a Consumer widget to rebuild the UI when the view model changes
      child: Consumer<T>(
        /// The builder method is called whenever the view model changes
        builder: widget.builder,
      ),
    );
  }
}