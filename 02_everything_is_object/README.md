はい。その前提なら、動画の途中で小さなコードを次々書くより、**GitHubに置く完成したサンプルプログラムを順番に実行・解析する構成**が合っています。

第2回では、サンプルを3本程度に分けると、READMEや後のnote記事にも流用しやすいです。

## おすすめのディレクトリ構成

第1回が `01_metaprogramming` なので、第2回は次が分かりやすいと思います。

```text
ruby_metaprogramming/
├── README.md
├── 01_metaprogramming/
│   └── ...
└── 02_everything_is_object/
    ├── README.md
    ├── sample1.rb
    ├── sample2.rb
    └── sample3.rb
```

テーマとの対応は、

```text
sample1.rb
Rubyでは値もオブジェクト
class / object_id

sample2.rb
クラスもオブジェクト
Object / Class / superclass

sample3.rb
オブジェクトへのメッセージ送信
メソッド呼び出し / send
```

とします。

この3段階なら、**「値 → クラス → メッセージ送信 → メタプログラミング」**という流れができます。

---

# 第2回 Rubyはすべてオブジェクト

## 数値もクラスもオブジェクト？

### オープニング

こんにちは、CodeBoost Laboです。

「Rubyのしくみを理解しよう！
～メタプログラミングの世界から理解するRuby～」

第2回です。

前回は、

「メタプログラミングとは何か？」

というところから、Railsのコードがなぜあれほど柔軟に書けるのか、その入り口を見てきました。

今回は、そのRubyのしくみを理解するための重要な考え方、

**「Rubyはすべてオブジェクト」**

について見ていきます。

Rubyでは、文字列だけではなく数値もオブジェクトです。

さらに、

**クラスそのものもオブジェクトです。**

今回は3つのサンプルプログラムを実際に動かしながら、

`Object`、`class`、`object_id`、そして「メッセージ送信」という考え方を見ていきます。

---

# 今回使用するサンプルプログラム

今回使用するプログラムはGitHubで公開しています。

ディレクトリには3つのRubyプログラムがあります。

```text
02_everything_is_object/
├── README.md
├── sample1.rb
├── sample2.rb
└── sample3.rb
```

まず `sample1.rb` で、数値や文字列などのオブジェクトを調べます。

次に `sample2.rb` で、クラス自身もオブジェクトであることを確認します。

最後に `sample3.rb` で、Rubyのメソッド呼び出しを「メッセージ送信」という視点から見てみます。

それでは、順番に確認していきましょう。

---

# Sample1 値もオブジェクト

まずは `sample1.rb` です。

## sample1.rb

```ruby
values = [
  1,
  3.14,
  "Hello",
  true,
  nil
]

values.each do |value|
  puts "value: #{value.inspect}"
  puts "class: #{value.class}"
  puts "object_id: #{value.object_id}"
  puts
end
```

Rubyでは、オブジェクトがどのクラスに属しているかを `class` で調べることができます。

また、`object_id` を使うと、そのオブジェクトを識別するためのIDを確認できます。

それでは実行してみましょう。

```bash
ruby sample1.rb
```

実行すると、このように表示されます。

```text
value: 1
class: Integer
object_id: ...

value: 3.14
class: Float
object_id: ...

value: "Hello"
class: String
object_id: ...

value: true
class: TrueClass
object_id: ...

value: nil
class: NilClass
object_id: ...
```

`object_id` の具体的な値は、実行環境などによって異なる場合があります。

ここで注目してほしいのは `class` です。

数値の `1` は、

```ruby
1.class
```

とすると、

```text
Integer
```

になります。

文字列だけではありません。

浮動小数点数、真偽値、`nil` にも、それぞれクラスがあります。

つまりRubyでは、

**数値や文字列などの値も、すべてオブジェクトとして扱われています。**

だから、

```ruby
1.class
```

のように、数値に対してメソッドを呼び出すことができます。

---

# object_idとは？

もう一つ、Sample1では `object_id` を表示しています。

```ruby
value.object_id
```

`object_id` は、Rubyがオブジェクトを識別するために使用する整数値です。

たとえば、同じStringクラスから作られた2つの文字列を見てみましょう。

```ruby
str1 = "Hello"
str2 = "Hello"
```

見た目は同じ `"Hello"` です。

しかし、それぞれ別のオブジェクトとして作られていれば、`object_id` を使ってその違いを確認できます。

ここでは、

**Rubyでは一つひとつのオブジェクトを識別できる**

ということを押さえておきましょう。

---

# Sample2 クラスもオブジェクト？

続いて `sample2.rb` を見てみましょう。

ここからが今回の重要なポイントです。

## sample2.rb

```ruby
class User
end

user = User.new

puts "user.class: #{user.class}"
puts "User.class: #{User.class}"
puts "User.superclass: #{User.superclass}"
puts "User.object_id: #{User.object_id}"
puts "Object.class: #{Object.class}"
puts "Class.class: #{Class.class}"
```

実行してみます。

```bash
ruby sample2.rb
```

実行結果です。

```text
user.class: User
User.class: Class
User.superclass: Object
User.object_id: ...
Object.class: Class
Class.class: Class
```

順番に見ていきましょう。

まず、

```ruby
user.class
```

は、

```text
User
```

です。

これは分かりやすいですね。

`user` は、Userクラスから作られたオブジェクトです。

---

# User.classを見てみよう

では、次です。

```ruby
User.class
```

結果は、

```text
Class
```

です。

ここがRubyの面白いところです。

`User` はクラスですが、そのUser自身もRubyの世界ではオブジェクトです。

そして、

**UserはClassクラスのオブジェクト**

になっています。

図にすると、

```text
user
  │
  │ .class
  ▼
User
  │
  │ .class
  ▼
Class
```

となります。

「クラスを使ってオブジェクトを作る」

だけではありません。

Rubyでは、

**そのクラス自身もオブジェクトとして存在しています。**

---

# Objectとの関係

もう一つ確認してみましょう。

```ruby
User.superclass
```

結果は、

```text
Object
```

です。

Userクラスでは、継承元を明示していません。

このような通常のクラスは `Object` を継承します。

```text
Object
   ▲
   │ 継承
 User
   │
   │ インスタンス
   ▼
 user
```

ここで少し注意が必要です。

`Object` と `Class` は、同じ関係を表しているわけではありません。

```ruby
User.superclass
```

は、

**Userが何を継承しているのか**

を調べています。

一方、

```ruby
User.class
```

は、

**Userというオブジェクト自身が何クラスのオブジェクトなのか**

を調べています。

つまり、

```text
User.superclass
      ↓
    Object

User.class
      ↓
    Class
```

です。

この2つを分けて考えると、Rubyのオブジェクトモデルが少し見えやすくなります。

---

# Classもオブジェクト？

そしてSample2の最後です。

```ruby
Class.class
```

結果は、

```text
Class
```

になります。

Class自身もClassクラスのオブジェクトです。

少し不思議ですよね。

Rubyではクラスもオブジェクトとして扱われるため、

```ruby
User.object_id
```

のように、クラスに対して `object_id` を呼び出すこともできます。

ここは今の段階ですべてを深く理解する必要はありません。

まずは、

**Rubyではクラスもオブジェクト**

ということを覚えておいてください。

この特徴が、これから学んでいくメタプログラミングにつながっていきます。

---

# Sample3 メッセージを送る

最後は `sample3.rb` です。

Rubyのメソッド呼び出しを、少し違う視点から見てみましょう。

## sample3.rb

```ruby
message = "hello"

puts message.upcase

puts message.send(:upcase)

method_name = :upcase
puts message.send(method_name)
```

実行します。

```bash
ruby sample3.rb
```

結果は、

```text
HELLO
HELLO
HELLO
```

となります。

---

# メソッド呼び出しを考える

最初は、いつも使っている普通のメソッド呼び出しです。

```ruby
message.upcase
```

これは、

`message` が参照しているStringオブジェクトの `upcase` メソッドを呼び出しています。

Rubyのオブジェクト指向では、これを、

**オブジェクトにメッセージを送る**

と考えることができます。

```text
message
   │
   │ upcase
   ▼
Stringオブジェクト
   │
   ▼
 "HELLO"
```

つまり、

```ruby
message.upcase
```

は、

`message` が参照するオブジェクトに、

「upcase」

というメッセージを送っている、と捉えることができます。

---

# sendを使ってみよう

次のコードを見てみます。

```ruby
message.send(:upcase)
```

これも結果は、

```text
HELLO
```

です。

`send` を使うことで、呼び出すメソッドをシンボルなどで指定できます。

さらに、

```ruby
method_name = :upcase

message.send(method_name)
```

とすることもできます。

ここが重要です。

呼び出すメソッドを、コードに直接、

```ruby
.upcase
```

と固定して書くのではなく、

変数に入れて、実行時に決めることができます。

---

# メタプログラミングへのつながり

第1回では、メタプログラミングについて見てきました。

今回見てきたRubyの特徴は、そのメタプログラミングの土台になります。

Rubyでは、

数値もオブジェクト。

文字列もオブジェクト。

そして、

**クラスもオブジェクトです。**

さらに、オブジェクトに対してメッセージを送り、動的にメソッドを呼び出すこともできます。

```text
値もオブジェクト
       │
       ▼
クラスもオブジェクト
       │
       ▼
オブジェクトにメッセージを送る
       │
       ▼
動的にRubyの振る舞いを扱える
       │
       ▼
メタプログラミング
```

Rubyでは、プログラムを構成するものをオブジェクトとして扱える。

この柔軟さが、Rubyのメタプログラミングを支えています。

---

# まとめ

今回は、

**「Rubyはすべてオブジェクト」**

というテーマで、3つのサンプルプログラムを見てきました。

Sample1では、

数値や文字列などもオブジェクトであることを確認しました。

Sample2では、

クラス自身もオブジェクトであり、UserクラスがClassクラスのオブジェクトであることを確認しました。

そしてSample3では、

メソッド呼び出しを「オブジェクトへのメッセージ送信」という視点から見て、`send` を使った動的なメソッド呼び出しも確認しました。

今回特に覚えておいてほしいのは、

**「Rubyではクラスもオブジェクト」**

ということです。

この考え方が、これからRubyのメタプログラミングを理解していくうえで重要になってきます。

次回は、さらにRubyのしくみを深掘りしていきましょう。

それではまた次回、お会いしましょう。

---

この構成なら、GitHubのREADMEもほぼ同じ順番で、

**「概要 → ディレクトリ構成 → Sample1 → Sample2 → Sample3 → メタプログラミングとの関係 → まとめ」**

と作れます。

また、今回は `sample1.rb` に `class` と `object_id`、`sample2.rb` に `Object` / `Class`、`sample3.rb` にメッセージ送信を明確に分けたので、**動画を見ない人がGitHubだけを読んでも各サンプルの目的が分かる構成**になります。
