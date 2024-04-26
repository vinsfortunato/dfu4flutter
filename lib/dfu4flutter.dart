export 'src/dfu_device.dart';
export 'src/dfu_progress_update.dart';
export 'src/desktop/dfu_desktop.dart';

import 'src/dfu_device.dart';
import 'src/dfu_platform_interface.dart';

class Dfu {
  static Future<List<DfuDevice>> getDevices() {
    return DfuPlatform.instance.getDevices();
  }
}
