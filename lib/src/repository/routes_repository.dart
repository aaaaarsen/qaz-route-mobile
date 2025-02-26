import 'package:qaz_route_mobile/src/model/route_model.dart';

final class RoutesRepository {
  RoutesRepository._();

  static final RoutesRepository _instance = RoutesRepository._();

  factory RoutesRepository() => _instance;

  Future<List<RouteModel>> getRoutes() async {
    await Future.delayed(const Duration(milliseconds: 800));

    return _mockRoutes;
  }

  final List<RouteModel> _mockRoutes = [
    const RouteModel(
      id: 'alm-001',
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSgoMVm24NES2h7i1aOl6yXVySL6sKo9GdI4g&s',
      title: 'Medeu',
      location: 'Medeu District, Almaty',
    ),
    const RouteModel(
      id: 'alm-002',
      imageUrl:
          'https://tvnews.by/uploads/posts/2019-06/1559382378_f3ad69924fb1b88888862bc9a8c2527d.jpg',
      title: 'Kok-Tobe Hill',
      location: 'Bostandyk District, Almaty',
    ),
    const RouteModel(
      id: 'alm-003',
      imageUrl:
          'https://welcome.kz/ru/assets/images/products/0_gallery/locations/almaty/gorky-park.jpeg',
      title: 'Almaty Central Park',
      location: 'Almaly District, Almaty',
    ),
    const RouteModel(
      id: 'alm-004',
      imageUrl:
          'https://grandevoyage.kz/wp-content/uploads/2020/12/840-600whatsapp-image-2019-08-21-at-15.17.40-1.jpeg',
      title: 'Big Almaty Lake',
      location: 'Ile-Alatau National Park, Almaty',
    ),
  ];
}
