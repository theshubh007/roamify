import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

class Image_Encodeing {
  Future<String> decodeToBase64String(String compressedBase64) async {
    // Decode the compressed image from base64 to bytes
    List<int> compressedBytes = base64Decode(compressedBase64);

    // Get a temporary directory to save the compressed image
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;

    Uint8List compressedUint8List = Uint8List.fromList(compressedBytes);

    // Write the compressed bytes to a temporary file
    String compressedImagePath = '$tempPath/compressed_image.jpg';
    File(compressedImagePath).writeAsBytesSync(compressedUint8List);

    // Read the temporary compressed image file
    Uint8List originalBytes = await File(compressedImagePath).readAsBytes();

    // Delete the temporary compressed image file
    File(compressedImagePath).deleteSync();

    // Encode the original bytes as base64
    String originalBase64 = base64Encode(originalBytes);

    return originalBase64;
  }
}
