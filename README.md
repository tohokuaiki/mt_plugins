
## RsyncToPublic
実行するシェルコマンドを日時指定で実行するプラグイン。
日時やシェルコマンドはプラグイン設定から行います。1回実行したら日時は消去されます。繰り返し実行には向いておりません。

プラグインの名称は、MovableTypeが吐き出す環境はプレビュー用にして、公開環境は別にしたいよねっていう場合にrsyncコマンドを実行したかったので作った時のものが反映されています。
途中までコマンド固定で書いてたけど、だったら実行するシェルコマンドを設定できるようにすればもっと汎用性あがるんじゃね？ってことで。

実行日時はrun-periodic-tasksにひっかけているので、run-periodic-tasksの実行タイミングに依存します。
過去に設定すると次にrun-periodic-tasksが実行された時点でコマンドが実行されます。

## htpasswd_modifier
htpasswdで使用するパスワードをCrypt::Bcrypt/Crypt::PasswdMD5/Digest::SHAの順にハッシュ化するMovable Type のグローバルモディファイアhtpasswdを追加するプラグイン。
Basic認証用の.htpasswdをMovableTypeで作成して変更したい場合に使います。

使用するハッシュ形式は以下の優先順位です。どのモジュールも無いとエラー文字列を出します。

Crypt::Bcrypt  
Crypt::Passwd  
MD5/Digest::SHA  

### 使い方（一例です）実際に試しながらやってください。
####  カスタムコンテンツ定義の作成
 新規でカスタムコンテンツ定義を作り、ユーザー名を入れるテキストとパスワードを入れるテキストの2つを定義します。  
 以下、このカスタムコンテンツの名前を「htpasswdコンテンツ」、IDを7、ユーザー名のテキストの名前をusername、パスワードのテキストの名前をpasswordとします。  

#### カスタムテンプレートの作成
以下のようなインデックステンプレートを作成します。
  ``` 
  <mt:Contents content_type="7">
  <mt:ContentField content_field="ユーザー名"><mt:ContentFieldValue></mt:ContentField>:<mt:ContentField content_field="パスワード"><mt:ContentFieldValue htpasswd="1"></mt:ContentField>
  </mt:Contents>
  ```
出力先ファイル名を任意の.htpasswdにします。
#### カスタムコンテンツの作成
 ユーザー名とパスワードをカスタムコンテンツのメニューから作成してください。3つ作成すれば以下のように出力されます。  
test:$apr1$Vq9MBoET$6uNsnGQStbA5P6sO8ouMz/  
foo:$apr1$7FWNzMjR$fRp0bN6v2ZAHi6g7uUWMz/  
bar:$apr1$797AdmGi$P4pVJqZsbQcDdyBAS.8Hb/  
