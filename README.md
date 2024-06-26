# SWE-agent の動作確認用プログラム

本プログラムは、 SWE-agent ( https://github.com/princeton-nlp/SWE-agent ) の動作確認を容易にする目的で作成されたプログラムです。

## 動作確認環境

本プログラムは、以下の環境で動作を確認しました。

- CPU: Apple M3 Max
- OS: macOS 14.5
- Docker Desktop Version: 4.30.0

## 設定方法

SWE-agentの動作を制御する設定は `.env` ファイルに記述します。
`.env.sample` を `.env` にコピーして以下の通り編集してください。

- OPENAI_API_KEY: 'OPENAI_API_KEY' をOpenAIのAPIキーに置き換えてください。
- MODEL_NAME: 'gpt4' のまま、または [SWE-agentの公式FAQ](https://princeton-nlp.github.io/SWE-agent/usage/usage_faq/) に記載されているモデル名に置き換えてください。
- ISSUE_URL: SWE-agent で解決したい GitHub イシューの URL に置き換えてください。
- BASE_COMMIT: SWE-agent で解決するイシューを含む状態のリポジトリの コミットID (SHA) に置き換えてください。BASE_COMMIT は、すでに解決済みのイシューを使ってテストしたい場合に、イシューが存在する状態のコードを指定するための環境変数です。[SWE-agnetの公式のスクリプトのREADME.md](https://github.com/princeton-nlp/SWE-agent/blob/main/scripts/README.md#environment-arguments) も確認してください。

### 設定内容の例( .env.sample の説明 )

`.env.sample` は、 pytest の開発リポジトリの[イシューNo.11758](https://github.com/pytest-dev/pytest/issues/11758)のイシューを解決するための設定がなされています。
[イシューNo.11758](https://github.com/pytest-dev/pytest/issues/11758)のイシューは2024年5月末時点においてはすでに解決済みのイシューですが、イシューが解決される直前のコードをチェックアウトするように、 BASE_COMMIT が設定されています。
また、コード解釈・生成に使用するLLMは `gpt4` を使うように MODEL_NAME が設定されています。

```
OPENAI_API_KEY='OPENAI_API_KEY'
ISSUE_URL='https://github.com/pytest-dev/pytest/issues/11758'
MODEL_NAME='gpt4'
BASE_COMMIT='a53984a55b35235a21b4142822a9dd10d7e995f1'
```

## 実行方法
シェルで `run.sh` のあるディレクトリに移動して `run.sh` を実行すると SWE-agent が起動します。
起動した SWE-agent は、`.env` ファイルに設定した環境変数に従って動作します。
処理結果は、 trajectories フォルダに出力されます。

元々 trajectories フォルダに含まれているファイルは、
`.env.sample` の設定で SWE-agent を実行して出力されたファイルです。

## 備考

動作確認環境以外では動作しない可能性があります。
動作しない場合はご連絡ください。
