# ベースイメージ
FROM ruby:3.2.0

# 環境変数の設定（インタラクティブなプロンプトを抑制）
ENV DEBIAN_FRONTEND=noninteractive

# 必要パッケージのインストール
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  yarn \
  && ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
  && dpkg-reconfigure -f noninteractive tzdata \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# 作業ディレクトリを作成
WORKDIR /app

# Gemfile, Gemfile.lock をコピーして bundle install
COPY Gemfile Gemfile.lock ./
RUN bundle install --without development test

# アプリケーションファイルをコピー
COPY . .

# tmp/pids ディレクトリ作成（Pumaが必要とする）
RUN mkdir -p tmp/pids

# Entrypoint スクリプトのコピー
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

# EntrypointとCMDの設定
ENTRYPOINT ["entrypoint.sh"]
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]

