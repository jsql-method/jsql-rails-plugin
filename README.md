# Jsql rails plugin

Oprogramowanie opracowane przez firmę JSQL Sp. z o.o. w ramach prowadzonego projektu:

Opracowanie nowej metody procesu tworzenia oprogramowania poprzez optymalizację architektury warstwowej typu klient-serwer
Spółka JSQL sp. z.o.o. bierze udział w programie realizując projekt pt.:

“Opracowanie nowej metody procesu tworzenia oprogramowania poprzez optymalizację architektury warstwowej typu klient-serwer”

współfinansowanym przez Unię Europejską ze środków Regionalnego Programu Operacyjnego Województwa Zachodnipomorskiego 2014-2020

Oś priorytetowa 1 Gospodarka, Innowacje, Nowoczesne Technologie.
Działanie: 1.1. Projekty badawczo-rozwojowe przedsiębiorstw
Typ projektu 2

Projekty badawczo-rozwojowe przedsiębiorstw wraz z przygotowaniem do wdrożenia w działalności gospodarczej
Wartość Projektu: 1 380 501,67 PLN
Wkład Funduszy Europejskich: 1 090 679,25 PLN

Zakres i cel Projektu:
Przedmiotem Projektu jest opracowanie nowej metody procesu tworzenia oprogamowania poprzez optymalizację architektury warstwowej typu klient-serwer, dzięki której uzyskane zostaną znaczące ułatwienia oraz optymalizacje na wszystkich płaszczyznach tworzenia oraz utrzymywania oprogramownia, m.in. zmniejszony koszt zasobów ludzkich, zmniejszony koszt utrzymywania projektu, zmniejszona ilość kodu źródłoweog projektu, możliwości przesunięcia zasobów na inne projekty.

Proces badawczy składa się z 4 etapów/Zadań badawczych:
1. Opracowanie modelu teoretycznego nowej metody tworzenia oprogramowania JSQL
2. Eksperymenty badawcze – badania nad nową metodą tworzenia oprogramowania JSQL
3. Budowa i demonstracja prototypu nowej metody tworzenia oprogramowania JSQL
4. 
This is plugin for JSQL - sql with only front-end layer. 

## Usage
Gem creates four end points for executing encoded sql queries.
jsql/select, jsql/update, jsql/insert, jsql/delete, and one for 
transactions : jsql/commit.

## Installation
Jsql gem works with Ruby version under 2.6.0 and Rails 5.2.2
If you don't have Rails installed yet you have to type in your console:
```bash
$ gem install rails
```
Add this line to your application's Gemfile:

```ruby
gem 'jsql'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install jsql
```

## Contributing
In your application.rb file you have to add this code:
```ruby
Jsql.configure do |config|
      config.api_key = 'your_api_key'
      config.member_key = 'your_member_key'
    end
    
```
To get your api and member key you have to register on jsql.it.
## License

 * Copyright (c) 2018 JSQL Sp.z.o.o. (Ltd, LLC) www.jsql.it
 * Licensed under the ISC license

