# via-layouts

VIAで使うキーボードのレイアウトを管理するリポジトリ。
各機種の現在の設定を1つのレイアウトJSONで管理し、設定内容と導入手順を記録する。
このJSONを設定の唯一の正本（SSOT）とし、以前の設定はGitの履歴で管理する。
Windowsで使っていたEmacs風キーバインドのAutoHotkeyスクリプトも参考として収録している。

## キーボード

| 機種 | ディレクトリ | カスタマイズ |
| --- | --- | --- |
| Impact 80 JIS | [impact_80](impact_80/) | CapsLockを押している間のEmacs風移動・編集、Shiftによる範囲選択、CapsLock＋EscによるCapsLock切替 |

Impact 80 JISのキー一覧と詳しい導入手順は[機種別README](impact_80/README.md)を参照。
現在の設定はWindowsのJIS配列向けで、MacのFn面をEmacs面に転用している。

## 構成

```text
.
├── README.md
├── impact_80/
│   ├── README.md
│   └── impact_80_jis.layout.json
├── emacs.ahk
└── capslock-toggle.ahk
```

| ファイル | 用途 |
| --- | --- |
| [impact_80_jis.layout.json](impact_80/impact_80_jis.layout.json) | Impact 80 JISの現在の設定の正本。Emacs風操作と追加マクロを含む |
| [emacs.ahk](emacs.ahk) | 以前のAHK実装。右Ctrlによる移動・編集、アプリ別除外、Listary呼び出しを含む参考資料 |
| [capslock-toggle.ahk](capslock-toggle.ahk) | CapsLockを右Ctrlへレジストリ変換したWindows PC用の、CapsLock切替専用AHK |

AHKファイルはAutoHotkey v1.1用。
VIA版にはアプリ別除外とListary呼び出しを実装していない。

## 使い方

1. VIAで現在のキーボード設定をSaveしておく。
2. ConfigureのSave + Loadから、対象機種の正本のレイアウトJSONをLoadする。
   Impact 80 JISでは`impact_80/impact_80_jis.layout.json`を使う。
   このJSONは保存済みキー配置で、Designから読み込むキーボード定義とは別。
3. 各機種のREADMEに従って、キー操作と復帰を実機で確認する。

Impact 80 JISでは、レジストリ変更なしのPCはVIAだけで使用できる。
CapsLockを右Ctrlに変更したPCでは、元の`emacs.ahk`を終了し、
`capslock-toggle.ahk`を起動する。両スクリプトを同時に起動しない。

## レイアウトの追加・更新

- 機種ごとのディレクトリに、現在の設定の正本となるレイアウトJSONを1つと`README.md`を置く。
- VIAで設定を変えたらSaveした内容で正本のJSONを更新し、機種別READMEも実際の設定に合わせる。
- 古い設定や用途別のコピーを並行管理せず、変更履歴と復元はGitを使う。
- 機種別READMEには、対象OS・配列、レイヤーとマクロの割り当て、導入・復元手順を記載する。
- 実機で確認した動作と未確認の動作を記録する。
- 新しい機種を追加したら、このREADMEのキーボード一覧にも追加する。

レイアウトの変更履歴はGitで管理する。
