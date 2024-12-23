#include "include/dfu4flutter/dfu4flutter_plugin.h"

#include <flutter_linux/flutter_linux.h>
#include <gtk/gtk.h>
#include <sys/utsname.h>

#include <cstring>

#include "dfu4flutter_plugin_private.h"

#define DFU4FLUTTER_PLUGIN(obj) \
  (G_TYPE_CHECK_INSTANCE_CAST((obj), dfu4flutter_plugin_get_type(), \
                              Dfu4flutterPlugin))

struct _Dfu4flutterPlugin {
  GObject parent_instance;
};

G_DEFINE_TYPE(Dfu4flutterPlugin, dfu4flutter_plugin, g_object_get_type())

// Called when a method call is received from Flutter.
static void dfu4flutter_plugin_handle_method_call(
    Dfu4flutterPlugin* self,
    FlMethodCall* method_call) {
  g_autoptr(FlMethodResponse) response = nullptr;

  response = FL_METHOD_RESPONSE(fl_method_not_implemented_response_new());

  fl_method_call_respond(method_call, response, nullptr);
}

static void dfu4flutter_plugin_dispose(GObject* object) {
  G_OBJECT_CLASS(dfu4flutter_plugin_parent_class)->dispose(object);
}

static void dfu4flutter_plugin_class_init(Dfu4flutterPluginClass* klass) {
  G_OBJECT_CLASS(klass)->dispose = dfu4flutter_plugin_dispose;
}

static void dfu4flutter_plugin_init(Dfu4flutterPlugin* self) {}

static void method_call_cb(FlMethodChannel* channel, FlMethodCall* method_call,
                           gpointer user_data) {
  Dfu4flutterPlugin* plugin = DFU4FLUTTER_PLUGIN(user_data);
  dfu4flutter_plugin_handle_method_call(plugin, method_call);
}

void dfu4flutter_plugin_register_with_registrar(FlPluginRegistrar* registrar) {
  Dfu4flutterPlugin* plugin = DFU4FLUTTER_PLUGIN(
      g_object_new(dfu4flutter_plugin_get_type(), nullptr));

  g_autoptr(FlStandardMethodCodec) codec = fl_standard_method_codec_new();
  g_autoptr(FlMethodChannel) channel =
      fl_method_channel_new(fl_plugin_registrar_get_messenger(registrar),
                            "dfu4flutter",
                            FL_METHOD_CODEC(codec));
  fl_method_channel_set_method_call_handler(channel, method_call_cb,
                                            g_object_ref(plugin),
                                            g_object_unref);

  g_object_unref(plugin);
}
