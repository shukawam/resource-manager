# OKE Handson IaC 化

## 目的

特に中／上級の受講者の負担を減らすために、クラスタの作成を自動化したい。クイック作成では、インスタンスのイメージ、K8s のバージョンの選択が不可なのでチュートリアルが問題なく実施できる Oracle Linux のバージョン、K8s のバージョンを選択した上でクラスタ作成を行う。

## やり方

- oracle-japan/tutorial-resource-manager のようなリポジトリを作成し、OCI Tutorials 内で RM/TF によって自動作成させるテンプレートを格納する
- とりあえず動くもの（[https://github.com/shukawam/resource-manager/tree/main/examples/oke-cluster-for-tutorials](https://github.com/shukawam/resource-manager/tree/main/examples/oke-cluster-for-tutorials)）を元にリファクタリングする
  - ※やりずらいようであれば、各リソースなど適度に参考にしつつ新しく作っても良いです
- 規約は、Google が出している [Terraform を使用するためのベスト プラクティス](https://cloud.google.com/docs/terraform/best-practices-for-terraform?hl=ja) に従う？
  - ここ相談したい
  - 読んでた本（Terraform Up and Running）では、こんな構成でした
    - [https://github.com/brikis98/terraform-up-and-running-code/tree/master/code/terraform/08-production-grade-infrastructure/small-modules](https://github.com/brikis98/terraform-up-and-running-code/tree/master/code/terraform/08-production-grade-infrastructure/small-modules)
    - examples/\* -> モジュールの使い方例を示すために最小限でプロビジョニング可能なもの（モジュールのテストとかもこれを使う）
    - live/\* -> 実環境に対応する。oke-tutorial とか devops-tutorial とかそういうものができるイメージ
    - modules/\* -> Terraform モジュールを格納する
- コンフリクトしない範囲に適度に Issue 切って個人対応？
  - 一応レビュープロセス挟む？
  - ここ相談したい

## 気になっている点

コーディング規約以外の観点

- 再利用性が皆無
- 受講者に選択させるべきパラメータとそうではないパラメータをきちんと精査したい
  - ここ相談したい
- description とか一応ちゃんと書きたい
- GitHub から Deploy to Oracle Cloud ボタンを押させる方式で良いか...？
  - ここ相談したい

## 現状の構成概要

```bash
$ tree examples/oke-cluster-for-tutorials/
examples/oke-cluster-for-tutorials/
├── README.md
├── data_souces.tf // Data Source の定義一式
├── description.md
├── locals.tf // ローカル変数の定義一式
├── main-kube-config.tf // KubeConfig
├── main-network.tf // VCN 作成に必要なリソース一式
├── main-oke-cluster.tf // OKE のクラスタ関連リソース一式（OKE クラスタ、ノードプール）
├── outputs.tf // 出力変数（まともに使ってない）
├── provider.tf // プロバイダ情報
└── variables.tf // 変数定義

0 directories, 10 files
```
