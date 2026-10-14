# Impact 80 JIS

WindowsのJIS配列向け。[impact_80_jis.layout.json](impact_80_jis.layout.json)が現在の設定の唯一の正本（SSOT）。
VIAへの読み込みと設定の更新には、このファイルを使う。
[emacs.ahk](../emacs.ahk)は以前の実装の参考として保存している。
リポジトリ全体の構成は[ルートREADME](../README.md)を参照。

## 導入

1. VIAでキーボードに接続し、念のため現在の設定をSaveしておく。
2. ConfigureのSave + Loadから`impact_80_jis.layout.json`をLoadする。
   Designのキーボード定義を読み込む操作とは別。
3. レジストリでCapsLockを右Ctrlに変更したPCでは、AutoHotkey v1.1で
   リポジトリ直下の[capslock-toggle.ahk](../capslock-toggle.ahk)を起動する。
   レジストリ未変更のPCでは起動不要。
4. 元の[emacs.ahk](../emacs.ahk)は終了する。CapsLock切替のホットキーが重複するため、
   専用AHKとの同時起動は避ける。

レジストリの変更は不要。このファイル群はレジストリを変更しない。
変更済みのPCでは、専用AHKを終了するとCapsLock＋Escによる切替ができなくなる。

## 操作

CapsLockを押している間だけレイヤー3が有効になり、離すと元に戻る。
下表はすべてCapsLockとの同時押し。

| キー | 動作 |
| --- | --- |
| N / P | 下 / 上 |
| F / B | 右 / 左 |
| A / E | Home / End |
| V | Page Down |
| H / D | Backspace / Delete |
| M / J | Enter |
| K | Shift＋End → Shiftを離す → Delete（カーソルから行末まで削除） |
| Esc | Shift＋CapsLockを送り、CapsLockのオン／オフを切り替える |

移動キーにShiftを加えると範囲選択になる。KのマクロはShiftを離して使う。
KはAHK版と同じ選択・削除操作で、Emacsのkill ringへの保存機能はない。
LにはListary呼び出しを割り当てていない。

Windows通常面のScroll Lock位置には、Win＋Alt＋Kを送るマクロM1を割り当てている。
起動する機能はPC側のショートカット設定による。

## レイヤー構成

- レイヤー0：Windows通常面。CapsLock位置は`MO(3)`、Fnは`MO(2)`、Scroll Lock位置は`MACRO(1)`。
- レイヤー1：Mac通常面。CapsLock位置は`KC_CAPS`、Fnの`MO(3)`からEmacs面が開く。
- レイヤー2：Windows Fn面。CapsLock位置は`MO(3)`。
- レイヤー3：Mac Fn面をEmacs面に転用。左右Shiftを通常のShiftに割り当て、
  上記以外の位置は`KC_TRNS`。
- CapsLock＋Esc：`S(KC_CAPS)`（Shift＋CapsLock）。

CapsLock位置はレイヤー3で透明なので、下のレイヤーのキーを使う。
左右Shiftは明示的に割り当て、Fn面の右Shift位置にある独自機能より優先する。
CapsLockとFnを両方押した場合、操作一覧の割り当てはレイヤー3が優先され、
そのほかのキーは有効な下位レイヤーに従う。

CapsLockはCtrlとしては動作しない。例えばCapsLock＋Cは通常のCになる。
Vim・Tera Term・VMware Player・Emacsなどでのアプリ別除外は行わない。
それらで通常のCtrl操作を使う場合は、物理Ctrlキーを使う。
MacでのCapsLock切替は今回の対象外。

## マクロ

| スロット | 割り当て | 内容 |
| --- | --- | --- |
| M0 | CapsLock＋K | `{KC_LSFT,KC_END}{KC_DEL}`：Shift＋Endで選択してDelete |
| M1 | Windows通常面のScroll Lock位置 | `{+KC_LGUI}{+KC_LALT}k{-KC_LALT}{-KC_LGUI}`：Win＋Alt＋K |

M2〜M15は空。

## 実機での確認

- CapsLock＋N/P/F/Bを押し、長押しで移動が繰り返されること。
- CapsLockを離すと通常の文字入力に戻ること。
- CapsLock＋Shift＋移動キーで範囲選択できること。
- A/E/V、H/D/M/Jと、作業用テキストでKの削除を確認すること。
- CapsLock＋Escを2回押し、大文字固定のオン／オフを確認すること。
  変更済みPCでは専用AHKを起動した状態で確認する。
- CapsLock＋Escの長押しで、AHKによる切替が連続しないこと。
- 通常のFn操作と、Fn→CapsLock／CapsLock→Fnの両順序での復帰を確認すること。
- CapsLock＋LがListaryを起動せず、Lが入力されること。
- Windows通常面のScroll Lock位置でWin＋Alt＋Kが送られること。

## 設定の更新・復元

VIAで設定を変更したらSaveし、`impact_80_jis.layout.json`をその内容で更新する。
レイヤーやマクロを変更した場合は、このREADMEも更新する。

以前の設定に戻す場合は、Gitの履歴から対象時点の`impact_80/impact_80_jis.layout.json`を取り出し、
VIAでLoadする。正本のJSONもその設定に更新し、復元した内容をGitに記録する。
