# RsyncToPublic
実行するシェルコマンドを日時指定で実行するプラグイン。

プラグインの名称は、MovableTypeが吐き出す環境はプレビュー用にして、公開環境は別にしたいよねっていう場合にRsyncコマンドを実行したかったので作った時のものが反映されています。
途中コマンド固定で書いてたけど、だったら実行するシェルコマンドを設定できるようにすればもっと汎用性あがるんじゃね？ってことで。

実行日時はrun-periodic-tasksにひっかけているので、run-periodic-tasksの実行タイミングに依存します。
過去に設定すると次のrun-periodic-tasksが実行された時点でコマンドが実行されます。
