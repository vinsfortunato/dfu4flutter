//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <dfu4flutter/dfu4flutter_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) dfu4flutter_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "Dfu4flutterPlugin");
  dfu4flutter_plugin_register_with_registrar(dfu4flutter_registrar);
}
