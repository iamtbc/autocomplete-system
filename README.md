# オートコンプリートシステム

## 概要

このリポジトリでは [システム設計の面接試験](https://www.socym.co.jp/book/1406) 13章 で紹介されている「検索オートコンプリートシステムの設計」 の内容を元にオートコンプリート候補を取得するAPIサーバーの実装を行っています。

## 起動方法

1. システムを起動します。
    ```sh
    $ docker-compose up -d web
    ```

2. DBのセットアップを行います。
    ```sh
    $ docker-compose exec web bin/rails db:create
    $ docker-compose exec web bin/rails db:migrate
    $ docker-compose exec web bin/rails db:seed
    ```

3. 集計データからトライDBを更新します。
    ```sh
    $ docker-compose exec web bin/rails autocompletes:import
    ```


## 使用方法

1. システムを起動した後、 `GET http://localhost:3000/api/v1/autocomplete?q=<クエリ>` にリクエストします。
2. レスポンスから補完候補を取得できます。

  ```sh
  $ curl 'http://localhost:3000/api/v1/autocomplete?q=t' 
  [["tornado",11],["telephone",7]]
  ```

## テスト

このアプリケーションのテストを実行するためには以下のコマンドを使用してください:

  ```sh
  $ docker-compose exec web bundle exec rspec
  ```
