#include "include/dfu4flutter/dfu4flutter_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "dfu4flutter_plugin.h"

void Dfu4flutterPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  dfu4flutter::Dfu4flutterPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
