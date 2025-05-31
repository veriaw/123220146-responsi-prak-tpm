import 'package:hive/hive.dart';
import 'package:responsi_prak_mob/models/BookmarkModel.dart';

class BookmarkService {
  static const String _boxName = 'bookmarkBox';

  // Membuka box (panggil ini sekali saat app start)
  static Future<Box<BookmarkPhone>> openBox() async {
    return await Hive.openBox<BookmarkPhone>(_boxName);
  }

  // Tambah phone ke bookmark
  static Future<void> addBookmark(BookmarkPhone phone) async {
    final box = await openBox();
    await box.put(phone.id, phone); // simpan dengan key id supaya tidak duplikat
  }

  // Hapus bookmark berdasarkan id
  static Future<void> removeBookmark(int id) async {
    final box = await openBox();
    await box.delete(id);
  }

  // Cek apakah phone sudah di bookmark
  static Future<bool> isBookmarked(int id) async {
    final box = await openBox();
    return box.containsKey(id);
  }

  // Ambil semua data bookmark
  static Future<List<BookmarkPhone>> getAllBookmarks() async {
    final box = await openBox();
    return box.values.toList();
  }
}
