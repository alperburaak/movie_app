# movie_app

#  Movie App (Flutter + TMDB API)

This Flutter application allows users to browse top-rated movies, search for titles, and manage a list of favorite films using the The Movie Database (TMDB) API.

## Features

**Home Screen**

-Displays top-rated movies

-Infinite scroll for loading more pages dynamically

-Search bar with real-time query handling

**Favorites Screen**

-Displays movies the user has marked as favorites

-Favorites are stored locally using Hive and persist across sessions

**Movie Detail Screen**

-Shows detailed information about the selected movie (poster, overview, release date, rating, etc.)

## Technologies Used

| Area             | Technology                         |
|------------------|------------------------------------|
| UI Framework     | Flutter                            |
| State Management | Provider                           |
| HTTP Client      | Dio                                |
| Local Storage    | Hive                               |
| Code Generation  | Build Runner                       |
| Data Source      | TMDB (The Movie Database)          |



#  Movie App (Flutter + TMDB API)

Bu Flutter uygulaması, [The Movie Database (TMDB)](https://www.themoviedb.org/) API'si üzerinden top-rated (en yüksek puanlı) filmleri listeleyen, arama yapılabilen ve favorilere eklenebilen bir mobil film uygulamasıdır.

## Özellikler

 **Ana Sayfa**

  - En yüksek puanlı filmlerin listelenmesi
  - Sonsuz scroll (infinite scroll) ile sayfa sayfa film yükleme
  - Arama kutusu 
  
**Favoriler Sayfası**

  - Kullanıcının favoriye eklediği filmlerin listesi
  - Favoriler kalıcı olarak Hive ile cihazda saklanır

 **Detay Sayfası**

  - Filmin detaylı bilgileri (poster, açıklama, yayın tarihi, puan, vb.)

##  Kullanılan Teknolojiler

| Alan             | Teknoloji                          |
|------------------|------------------------------------|
| UI Framework     | Flutter                            |
| Durum Yönetimi   | Provider                           |
| HTTP İstekleri   | Dio                                |
| Veri Saklama     | Hive                               |
| Geliştirici Aracı| Build Runner                       |
| Kaynak API       | TMDB (The Movie Database)          |

##  Bağımlılıklar

```yaml
dependencies:
  flutter:
    sdk: flutter

  cupertino_icons: ^1.0.8
  dio: ^5.8.0+1
  provider: ^6.1.1
  cached_network_image: ^3.3.1
  shared_preferences: ^2.2.2
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  path_provider: ^2.1.1

dev_dependencies:
  flutter_test:
    sdk: flutter

  build_runner: ^2.4.6
  hive_generator: ^2.0.1

  flutter_lints: ^5.0.0
