abstract class Repository<T> {
  Stream<List<T>> listen();

  Future<void> markRead(List<T> items);
}
