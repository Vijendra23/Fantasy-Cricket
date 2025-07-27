// Import necessary Flutter package
import 'package:flutter/material.dart';

/// Define a base view model class that extends ChangeNotifier
/// This class can be used as a base class for other view models
class BaseViewModel extends ChangeNotifier {

  /// Method notify listeners about the change
  void updateUI() {
    notifyListeners();
  }

  /// Method to initialize the model
  /// This method can be overridden in subclasses to perform model-specific initialization
  void initModel() {
    /// Initialization code goes here
  }
}
