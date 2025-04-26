## インフラ構成・使用技術

本アプリケーションでは、本番環境を想定した以下の技術を導入しています。

- **Docker**：アプリケーション、Nginx、Cloudflaredをコンテナ化し、一貫性のある環境を構築
- **Nginx**：リバースプロキシサーバーとして導入。Pumaサーバー（Rails）との間に立ち、静的ファイル配信・リクエスト分散を最適化
- **Cloudflare Tunnel**：Cloudflare経由でHTTPS接続を提供し、安全なドメイン公開。
Tunnel内部も暗号化されており、自己署名証明書やLet's Encryptを用いずにセキュアな通信を実現。
- **SSH + GPG署名付きコミット**：安全なバージョン管理と認証
- **AWS非使用**：AWSに依存せず、自前でセキュアな本番運用環境を構築可能なスキルを実証

## 構成概要図（簡略）
Client ⇄ (HTTPS) ⇄ Cloudflare ⇄ (HTTPS) ⇄ Nginx (Reverse Proxy) ⇄ Puma (Rails)

## こだわりポイント

- 本番運用を見据えたHTTPS対応
- Docker Composeで一括起動可能な環境構成
- 極力軽量な構成を維持しつつ、セキュリティ・保守性を両立

## 開発環境情報

| 項目 | バージョン |
|:---|:---------|
| Docker | 28.1.1 |
| Docker Compose | v2.35.1 |
| Ruby | 3.2.0 |
| Rails | 7.0.8.7 |
| PostgreSQL | 15.12 |
| Nginx | 1.28.0 |
| Cloudflared | 2025.4.0 |


# テーブル設計

## users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| last_name          | string | null: false               |
| first_name         | string | null: false               |
| last_name_kana     | string | null: false               |
| first_name_kana    | string | null: false               |
| birth_date         | date   | null: false               |

### Association

- has_many :items
- has_many :orders

## items テーブル

| Column                    | Type       | Options                        |
| ------------------------- | ---------- | ------------------------------ |
| name                      | string     | null: false                    |
| price                     | integer    | null: false                    |
| description               | text       | null: false                    |
| category_id               | integer    | null: false                    |
| condition_id              | integer    | null: false                    |
| shipping_fee_burden_id    | integer    | null: false                    |
| prefecture_id             | integer    | null: false                    |
| shipping_date_estimate_id | integer    | null: false                    |
| user                      | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :order

## orders テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association

- belongs_to :item
- belongs_to :user
- has_one :address

## addresses テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| postal_code   | string     | null: false                    |
| prefecture_id | integer    | null: false                    |
| city          | string     | null: false                    |
| house_number  | string     | null: false                    |
| building_name | string     |                                |
| phone_number  | string     | null: false                    |
| order         | references | null: false, foreign_key: true |

### Association

- belongs_to :order