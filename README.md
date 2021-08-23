# このアプリについて
## データベース

### user
| カラム名 | データ型  |
|  ----   | ---- |
|  name |  string  |
|  email_address  |  string  |
|  password | string |

### task
| カラム名 | データ型 |
| ---- | ---- |
|name | string |
|description | text |
|priority | string |
|status | string |
|expiration_date | datetime |
|user_id | integer |
|task_label_id | integer |

### label
| カラム名 | データ型 |
| ---- |  ----  |
| task_id | integer |
| label_name | string |

# Herokuへのデプロイ手順

1.Macの場合

以下のコマンドを実行します。
```sh
$ heroku login
```
すると、以下のメッセージが表示され、間も無くブラウザが起動しログイン画面が表示されます。

2.Herokuに新しいアプリケーションを作成する


~/workspace/heroku_test_appに位置していることを確認して、Herokuに新しいアプリケーションを作成します。

```sh
$ heroku create
Creating app... done, ⬢ fierce-mountain-94329
https://fierce-mountain-94329.herokuapp.com/ | https://git.heroku.com/fierce-mountain-94329.git

```

これで新しいアプリケーションが作成されました。
上記の場合、https://fierce-mountain-94329.herokuapp.com/がアプリケーションのURLになります。URLは毎回異なります。

3.アセットプリコンパイルをする


アセットとは、Railsアプリケーションのapp/assets/以下のファイルの総称です。
例えばCSSやJavaScriptなどがあります。
アセットプリコンパイルとはアセット類を本番環境で実行できる形式に変換することです。
アセットプリコンパイルの詳細は、こちらのテキストを参考にしてください。

アセットプリコンパイルをするには下記のコマンドを実行します。

```sh
$ rails assets:precompile RAILS_ENV=production

```

4.GemfileのRubyのバージョンをコメントアウトする
>Gemfileのruby '2.6.5'となっている行をコメントアウトする。
>bundle installを実行する

5.コミットする

```sh
~/workspace/heroku_test_app (master) $ git add -A
~/workspace/heroku_test_app (master) $ git commit -m "init"

```

6.Heroku buildpackを追加する

```sh
$ heroku buildpacks:set heroku/ruby
$ heroku buildpacks:add --index 1 heroku/nodejs
```

7.Herokuにデプロイをする
```sh
$ git push heroku master
```

8.データベースの移行

```sh
$ heroku run rails db:migrate
