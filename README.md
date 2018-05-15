# README

Тестовое приложение по определию средствами HTML5 геолокации пользователя и выбора ближайшего магазина.
Перед установкой заменить database.sample.yml на database.yml

```ruby
bundle install
bundle exec rake db:create
bundle exec rake db:migrate
```    

Для наполнения бд тестовыми данными, запустить задачу:

```ruby
bundle exec rake shops_with_products:seed
```   

В результате будет создано три магазина с тремя товарами (с случайно ценой) в каждом.
