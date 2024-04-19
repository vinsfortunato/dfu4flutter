#ifndef FLUTTER_PLUGIN_DFU4FLUTTER_PLUGIN_H_
#define FLUTTER_PLUGIN_DFU4FLUTTER_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace dfu4flutter {

class Dfu4flutterPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  Dfu4flutterPlugin();

  virtual ~Dfu4flutterPlugin();

  // Disallow copy and assign.
  Dfu4flutterPlugin(const Dfu4flutterPlugin&) = delete;
  Dfu4flutterPlugin& operator=(const Dfu4flutterPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace dfu4flutter

#endif  // FLUTTER_PLUGIN_DFU4FLUTTER_PLUGIN_H_
